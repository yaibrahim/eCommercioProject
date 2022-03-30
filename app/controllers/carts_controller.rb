class CartsController < ApplicationController
  def index
    @cart = CartItem.user_cart(current_user.id)
  end

  def destroy
    puts request.format
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
end
