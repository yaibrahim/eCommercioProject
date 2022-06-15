class CartController < ApplicationController
  # before_action :authenticate_user!
  def index
    if current_user.present?
      @cart = CartItem.user_cart(current_user.cart.id)
    else
      @cart = session[:cart]
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
