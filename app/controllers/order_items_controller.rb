class OrderItemsController < ApplicationController
  def index
  end

  def new
    # order_item and cart_item should be merged together LineItem will be the new entity.
    @order_item = OrderItem.new
    # current_user.cart.cart_items is more appropriate here

    # current_cart should be set up in the project so that we can access current_user's cart anywhere in the controller/views/helpers

    @cart_item = CartItem.user_cart(current_user.id)
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    @cart_item = CartItem.user_cart(current_user.id)

    # this is ugly and slow process. think about maintaining both cart and order items in one single entity i.e LineItem
    @cart_item.each do |item|
      @order_item = OrderItem.new(order_item_params)
      @order_item.product_id = item.product_id
      @order_item.quantity = item.quantity
      @order_item.discount = 0
      @order_item.save
    end

    if @order_item.save

      # ugly code. redirect is kind of return and you are writing code below redirect. redirect should be the last line of any block
      redirect_to products_path
      flash[:alert] = 'Order is finalized'
      CartItem.delete_user_cart(current_user.id)
      flash[:notice] = 'Cart Cleared'
    else
      redirect_to products_path
      flash[:alert] = 'There is some issue in order creation'
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :quantity, :discount)
  end
end
