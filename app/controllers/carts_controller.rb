class CartsController < ApplicationController
  def index
    @cart = CartItem.user_cart(current_user.id)
  end

  def destroy
  end
end
