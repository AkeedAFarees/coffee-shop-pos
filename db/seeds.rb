# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
# Clear existing data
Store.destroy_all
Item.destroy_all

# Create stores
store1 = Store.create(name: "Coffee Haven", location: "Downtown")
store2 = Store.create(name: "Brewed Awakening", location: "Uptown")
store3 = Store.create(name: "Mug Life", location: "Midtown")

# Create items for store1
store1.items.create([
  { name: "Espresso", price: 2.50, category: "Coffee", description: "Strong and bold espresso." },
  { name: "Americano", price: 3.00, category: "Coffee", description: "Espresso with hot water." },
  { name: "Chocolate Croissant", price: 2.75, category: "Baked", description: "Flaky pastry with a chocolate filling." },
  { name: "Mug", price: 5.00, category: "Mugs", description: "A classic coffee mug." }
])

# Create items for store2
store2.items.create([
  { name: "Cappuccino", price: 3.50, category: "Coffee", description: "Espresso with steamed milk and foam." },
  { name: "Latte", price: 3.75, category: "Coffee", description: "Espresso with steamed milk." },
  { name: "Blueberry Muffin", price: 2.50, category: "Baked", description: "Freshly baked muffin with blueberries." },
  { name: "Travel Mug", price: 7.00, category: "Mugs", description: "Insulated travel mug for your coffee." }
])

# Create items for store3
store3.items.create([
  { name: "Flat White", price: 3.25, category: "Coffee", description: "Espresso with steamed milk, less foam." },
  { name: "Mocha", price: 3.50, category: "Coffee", description: "Espresso with steamed milk and chocolate." },
  { name: "Cinnamon Roll", price: 3.00, category: "Baked", description: "Sweet and spiced cinnamon roll." },
  { name: "Ceramic Mug", price: 6.00, category: "Mugs", description: "Handcrafted ceramic coffee mug." }
])

puts "Seed data created successfully!"

