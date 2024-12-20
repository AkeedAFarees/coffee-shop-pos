# app/models/order.rb
class Order < ApplicationRecord
    belongs_to :store
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items

    validates :status, inclusion: { in: ['pending', 'placed', 'completed'] }, allow_nil: true

    def update_total_amount
      self.total_amount = order_items.sum(:total_price)
      save
    end

    def apply_combos
      self.discounted_amount = 0 # Reset the discount amount before calculating
    
      store.combos.each do |combo|
        # Only apply discount if the combo applies to the current order
        if combo.applies_to?(order_items)
          total_discount = 0.00
    
          # Get the items that belong to this combo in the order
          combo_items = order_items.select do |order_item|
            combo.items.include?(order_item.item)  # Check if the order item is part of the combo
          end
    
          # Calculate the total price of all combo items in the order
          combo_total_price = combo_items.sum(&:total_price)

          # byebug
          # Apply the discount based on the combo's discount type
          if combo.discount_type == 'fixed'
            # Apply fixed discount directly to the total amount
            # total_discount += combo.discount_amount * combo_items.sum(&:quantity)
            total_discount += combo.discount_amount
          elsif combo.discount_type == 'percentage'
            # Apply percentage discount to the combined total price of the combo items
            discount = combo_total_price * combo.discount_amount / 100
            total_discount += discount
          end
    
          # Add the total discount for this combo to the overall discount amount
          self.discounted_amount += total_discount.round(2)
        end
      end

      # Update the order's total amount after applying discounts
      self.total_amount = order_items.sum(:total_price) - self.discounted_amount
      self.total_amount = self.total_amount.round(2)  # Round to 2 decimal places to avoid rounding errors
      save
    end    
    
  end
  