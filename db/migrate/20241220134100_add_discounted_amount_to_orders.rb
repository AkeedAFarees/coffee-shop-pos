class AddDiscountedAmountToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :discounted_amount, :decimal, default: 0.0
  end
end
