# app/models/store.rb
class Store < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :combos, dependent: :destroy
    
    validates :name, presence: true
    validates :location, presence: true
end
  