class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.paginate(page: params[:page], per_page: 4)
    authorize @orders
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
