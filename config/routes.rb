Rails.application.routes.draw do
  resources :stores
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "stores#index" 
  
  resources :stores, only: [:index, :new, :create, :show] do
    # Nested resources for items under each store
    resources :items, only: [:index]  # Show items for each store
    
    # Orders with routes to add/remove items from the order
    resources :orders, only: [:create, :show] do
      member do
        post :add_item     # Route to add items to an order
        post :remove_item  # Route to remove items from an order
        post :place_order
      end
    end
  end
  
end
