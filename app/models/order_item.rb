class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item

    validates :quantity, numericality: { greater_than: 0 }
    validates :total_price, numericality: { greater_than_or_equal_to: 0 }
    
    # Ensure that new order items have a quantity of 0 by default
    after_initialize :set_default_quantity, if: :new_record?

    private

    def set_default_quantity
        self.quantity ||= 0
    end
end
  