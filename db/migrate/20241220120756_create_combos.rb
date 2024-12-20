class CreateCombos < ActiveRecord::Migration[7.1]
  def change
    create_table :combos do |t|
      t.string :name, null: false
      t.string :description
      t.string :discount_type, null: false # e.g., "percentage" or "fixed"
      t.decimal :discount_amount, precision: 5, scale: 2, null: false
      t.json :combo_items, null: true # JSON array of item_ids
      
      t.references :store, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
