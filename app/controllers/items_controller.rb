# app/controllers/items_controller.rb
class ItemsController < ApplicationController
    before_action :set_store
  
    def index
      @items = @store.items
    end
  
    private
  
    def set_store
      @store = Store.find(params[:store_id])
    end
  end
  