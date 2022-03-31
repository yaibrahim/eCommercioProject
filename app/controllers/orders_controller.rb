class OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @cart_item = CartItem.user_cart(current_user.id)
    @status = :initiated
  end

  def create
    @order = current_user.orders.new(order_params)

    if @order.save
      redirect_to new_order_item_path(order_id: @order.id)
      flash[:alert] = 'Order assigned finalization needed..'
    else
      render :new
      flash[:alert] = 'there is some issue'
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :coupon_id)
  end
end
