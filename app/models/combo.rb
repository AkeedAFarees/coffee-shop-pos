class Combo < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :items, join_table: :combo_items

  validates :name, :discount_type, :discount_amount, presence: true
  validates :discount_amount, numericality: { greater_than: 0 }

  def applies_to?(order_items)
    return false if combo_items.nil?  # Prevent parsing if combo_items is nil

    item_ids_in_order = order_items.map(&:item_id)
    combo_item_ids = JSON.parse(combo_items)

    # Check if all combo items are present in the order
    (combo_item_ids - item_ids_in_order).empty?
  end

  def apply_discount(order)
    # Get the items that are part of the combo and the quantity of those items in the order
    order_items = order.order_items.where(item_id: item_ids)

    total_discount = 0
    order_items.each do |order_item|
      quantity = order_item.quantity
      # Apply discount logic
      if quantity > 0
        # Apply the discount to the appropriate number of items (up to the combo quantity)
        discounted_quantity = [quantity, combo_quantity_for(order_item)].min
        total_discount += discounted_quantity * discount_amount
      end
    end

    # Apply the total discount to the order's total amount
    order.total_amount -= total_discount
    order.discounted_amount = total_discount
    order.save!
  end

  # Helper method to determine how many of the combo item can be discounted
  def combo_quantity_for(order_item)
    # Assume combo is between two items
    [order_item.quantity, 1].min
  end
end
