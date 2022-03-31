class OrderItemsController < ApplicationController
  def index
  end

  def new
    @order_item = OrderItem.new
    @cart_item = CartItem.user_cart(current_user.id)
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    @cart_item = CartItem.user_cart(current_user.id)
    @cart_item.each do |item|
      @order_item = OrderItem.new(order_item_params)
      @order_item.product_id = item.product_id
      @order_item.quantity = item.quantity
      @order_item.discount = 0
      @order_item.save
    end

    if @order_item.save
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
