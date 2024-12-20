# db/seeds.rb
puts "Seeding database..."

# Clear existing data
OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
Store.destroy_all
Category.destroy_all
Combo.destroy_all

# Create categories
categories = {
  coffee: Category.find_or_create_by!(name: "Coffee"),
  baked: Category.find_or_create_by!(name: "Baked Goods"),
  mugs: Category.find_or_create_by!(name: "Mugs"),
  snacks: Category.find_or_create_by!(name: "Snacks"),
  tea: Category.find_or_create_by!(name: "Tea")
}

# Create stores
stores = [
  { name: "Coffee Haven", location: "Downtown" },
  { name: "Brewed Awakening", location: "Uptown" },
  { name: "Mug Life", location: "Midtown" },
  { name: "Tea Bliss", location: "Suburbs" },
  { name: "Snack Shack", location: "Beachfront" }
]

stores.each do |store_data|
  Store.find_or_create_by!(store_data)
end

# Create items
Store.all.each do |store|
  case store.name
  when "Coffee Haven"
    store.items.create!([
      { name: "Espresso", price: 2.50, category_id: categories[:coffee].id, description: "Strong and bold espresso." },
      { name: "Americano", price: 3.00, category_id: categories[:coffee].id, description: "Espresso with hot water." },
      { name: "Chocolate Croissant", price: 2.75, category_id: categories[:baked].id, description: "Flaky pastry with chocolate filling." },
      { name: "Mug", price: 5.00, category_id: categories[:mugs].id, description: "A classic coffee mug." }
    ])
  when "Brewed Awakening"
    store.items.create!([
      { name: "Cappuccino", price: 3.50, category_id: categories[:coffee].id, description: "Espresso with steamed milk and foam." },
      { name: "Latte", price: 3.75, category_id: categories[:coffee].id, description: "Espresso with steamed milk." },
      { name: "Blueberry Muffin", price: 2.50, category_id: categories[:baked].id, description: "Freshly baked muffin with blueberries." },
      { name: "Travel Mug", price: 7.00, category_id: categories[:mugs].id, description: "Insulated travel mug for your coffee." }
    ])
  when "Mug Life"
    store.items.create!([
      { name: "Flat White", price: 3.25, category_id: categories[:coffee].id, description: "Espresso with steamed milk, less foam." },
      { name: "Mocha", price: 3.50, category_id: categories[:coffee].id, description: "Espresso with steamed milk and chocolate." },
      { name: "Cinnamon Roll", price: 3.00, category_id: categories[:baked].id, description: "Sweet and spiced cinnamon roll." },
      { name: "Ceramic Mug", price: 6.00, category_id: categories[:mugs].id, description: "Handcrafted ceramic coffee mug." }
    ])
  when "Tea Bliss"
    store.items.create!([
      { name: "Green Tea", price: 2.50, category_id: categories[:tea].id, description: "Refreshing green tea." },
      { name: "Chai Latte", price: 3.50, category_id: categories[:tea].id, description: "Tea with milk and spices." },
      { name: "Scone", price: 2.75, category_id: categories[:baked].id, description: "A flaky and buttery scone." },
      { name: "Tea Infuser Mug", price: 8.00, category_id: categories[:mugs].id, description: "Mug with built-in tea infuser." }
    ])
  when "Snack Shack"
    store.items.create!([
      { name: "Trail Mix", price: 1.50, category_id: categories[:snacks].id, description: "A mix of nuts and dried fruits." },
      { name: "Granola Bar", price: 2.00, category_id: categories[:snacks].id, description: "Healthy snack bar." },
      { name: "Cold Brew Coffee", price: 3.25, category_id: categories[:coffee].id, description: "Chilled coffee with a smooth flavor." },
      { name: "Beach Mug", price: 4.50, category_id: categories[:mugs].id, description: "A beach-themed mug." }
    ])
  end
end

# Create combos
Store.all.each do |store|
  3.times do
    # Select two random items from different categories for each combo
    item1 = store.items.sample
    item2 = store.items.where.not(id: item1.id).sample

    # Create combo only if two items are found
    if item1 && item2
      # Randomly select a discount type (fixed or percentage)
      discount_type = ["fixed", "percentage"].sample

      # Randomly determine the discount amount based on the discount type
      if discount_type == "fixed"
        discount_amount = rand(1..5) # Random value between 1 and 5 for fixed discount
      else
        discount_amount = rand(5..25) # Random value between 5% and 25% for percentage discount
      end

      # Create the combo with the random values
      combo = store.combos.create!(
        name: "#{item1.name} & #{item2.name} Combo",
        description: "Get a discount when buying #{item1.name} and #{item2.name} together!",
        discount_type: discount_type,
        discount_amount: discount_amount,
        combo_items: [item1.id, item2.id].to_json  # Store combo items as a JSON array of item IDs
      )

      # Assign the items to the combo
      combo.items << item1
      combo.items << item2
    end
  end
end

puts "Seed data created successfully!"
