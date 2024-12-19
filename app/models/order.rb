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
  end
  