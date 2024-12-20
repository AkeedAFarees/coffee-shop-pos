class CreateComboItems < ActiveRecord::Migration[7.1]
  def change
    create_table :combo_items do |t|
      t.references :combo, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
