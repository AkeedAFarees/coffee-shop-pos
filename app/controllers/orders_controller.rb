class OrdersController < ApplicationController
    before_action :set_store
    before_action :set_order, only: [:show, :add_item, :remove_item, :place_order]
  
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

      @order_item.quantity += quantity
      @order_item.total_price = @order_item.quantity * @item.price
      @order_item.save
      @order.update_total_amount

      @order.apply_combos
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
      @order.apply_combos
      respond_to do |format|
        format.js
      end
    end

    def place_order
      # Mark the order as placed (assuming the model has a status field or similar)
      if @order.order_items.any?
        
        @order.update!(status: 'placed', placed_at: Time.current)

        # Enqueue the job to trigger the mail after 5 seconds
        ProcessOrderJob.set(wait: 5.seconds).perform_later(@order.id)
        flash[:notice] = 'Your order has been placed successfully. Please wait while it is being prepared.'
      else
        flash[:alert] = 'You cannot place an order with no items.'
      end
      # Redirect to the order show page or the store page
      redirect_to store_order_path(@store, @order) 
    end
  
    private
  
    def set_store
      @store = Store.find(params[:store_id])
    end
  
    def set_order
      @order = @store.orders.find(params[:id])
    end
  end
  