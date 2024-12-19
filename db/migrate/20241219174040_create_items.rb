class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.string :category
      t.text :description
      t.timestamps
    end
  end
end
