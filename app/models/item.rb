# app/models/item.rb
class Item < ApplicationRecord
    belongs_to :store
    has_many :order_items
    has_many :orders, through: :order_items
  
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :category, presence: true
    validates :description, presence: true
  end
  