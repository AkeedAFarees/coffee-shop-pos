class AddDefaultValueToQuantityInOrderItems < ActiveRecord::Migration[7.1]
  def change
    change_column_default :order_items, :quantity, 0
  end
end
