class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def detail
    order = Order.find_by(id: params[:id])
    if order.nil?
      redirect_to orders_path, notice: 'Order id not exist'
    else
      @order_detail = order.order_items
    end
  end

  def new
    @order = Order.new
    @cart_item = current_user.cart.cart_items
  end

  def create
    @order = current_user.orders.new(order_params)
    @cart_item = current_user.cart.cart_items

    if @order.save
      redirect_to new_order_item_path(order_id: @order.id), alert: 'Order assigned finalization needed..'
    else
      flash.now[:notice] = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :coupon_id)
  end
end
