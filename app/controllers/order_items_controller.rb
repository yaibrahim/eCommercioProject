class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @order_item = OrderItem.new
    @cart_item = current_user.cart.cart_items
  end

  def create
    @cart_item = current_user.cart.cart_items

    @cart_item.each do |item|
      @order_item = OrderItem.new(order_item_params)
      @order_item.product_id = item.product_id
      @order_item.quantity = item.quantity
      @order_item.save
    end

    if @order_item.save
      flash[:alert] = 'Order is finalized, Thanks for shopping'
      CartItem.delete_user_cart(current_user.cart.id)
      redirect_to products_path
    else
      redirect_to products_path, alert: @order_item.errors.full_messages.to_sentence
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :quantity, :discount)
  end
end
