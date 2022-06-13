class CartController < ApplicationController
  before_action :authenticate_user!
  def index
    @cart = CartItem.user_cart(current_user.cart.id)

    if @cart.nil?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    puts request.format
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'Cart Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
end
