class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :store, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2, default: 0.0
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
