class OrdersController < ApplicationController
    before_action :set_store
    before_action :set_order, only: [:show, :add_item, :remove_item]
  
    def create
      @order = @store.orders.create(status: "pending")
      redirect_to store_order_path(@store, @order)
    end
  
    def show
      @items = @store.items
    end
  
    def add_item
      @item = Item.find(params[:item_id])
      quantity = params[:quantity].to_i
      @order_item = @order.order_items.find_or_initialize_by(item: @item)

    #   @order_item.quantity ||= 0  # Set to 0 if it's nil
      @order_item.quantity += quantity
      @order_item.total_price = @order_item.quantity * @item.price
      @order_item.save
      @order.update_total_amount
      respond_to do |format|
        format.js
      end
    end
  
    def remove_item
      @item = Item.find(params[:item_id])
      @order_item = @order.order_items.find_by(item: @item)
      if @order_item
        @order_item.destroy
        @order.update_total_amount
      end
      respond_to do |format|
        format.js
      end
    end
  
    private
  
    def set_store
      @store = Store.find(params[:store_id])
    end
  
    def set_order
      @order = @store.orders.find(params[:id])
    end
  end
  