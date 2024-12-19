# app/models/item.rb
class Item < ApplicationRecord
    belongs_to :store
  
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :category, presence: true
    validates :description, presence: true
  end
  