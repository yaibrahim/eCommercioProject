class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def detail
    # what if we could set_order first and then you'll need to do
    # @order_details = @order.order_items

    @order_detail = OrderItem.where(order_id: params[:id])
  end

  def new
    @order = Order.new
    @cart_item = CartItem.user_cart(current_user.id)
    @status = :initiated # this should be the default value and we shouldn't need to add this here.
  end

  def create
    @order = current_user.orders.new(order_params)

    if @order.save
      redirect_to new_order_item_path(order_id: @order.id), alert: 'Order assigned finalization needed..'
    else
      render :new
      # flash nai chal rha hoga with render. google k flash and render kuen nai chalta
      flash[:alert] = 'there is some issue'
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :coupon_id)
  end
end
