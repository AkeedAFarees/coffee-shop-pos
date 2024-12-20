# app/models/item.rb
class Item < ApplicationRecord
    belongs_to :store
    belongs_to :category

    has_many :order_items
    has_many :orders, through: :order_items
    has_and_belongs_to_many :combos, join_table: :combo_items
  
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :category, presence: true
    validates :description, presence: true
  end
  