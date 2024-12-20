# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_20_134100) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "combo_items", force: :cascade do |t|
    t.integer "combo_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["combo_id"], name: "index_combo_items_on_combo_id"
    t.index ["item_id"], name: "index_combo_items_on_item_id"
  end

  create_table "combos", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "discount_type", null: false
    t.decimal "discount_amount", precision: 5, scale: 2, null: false
    t.json "combo_items"
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_combos_on_store_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.string "category"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_id", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["store_id"], name: "index_items_on_store_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "quantity", default: 0
    t.decimal "total_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "store_id"
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "placed_at"
    t.datetime "completed_at"
    t.decimal "discounted_amount", default: "0.0"
    t.index ["store_id"], name: "index_orders_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "combo_items", "combos"
  add_foreign_key "combo_items", "items"
  add_foreign_key "combos", "stores"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "stores"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "stores"
end
