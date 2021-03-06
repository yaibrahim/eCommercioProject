# remove this if unncessary
class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def index
    order = Order.find_by(id: params[:id])
    authorize order, policy_class: OrderDetailPolicy
    if order.nil?
      redirect_to orders_path, notice: 'Order id not exist'
    else
      @order_detail = order.order_items
    end
  end
end
