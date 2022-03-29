class CartsController < ApplicationController
  def index
    # @cart = CartItem.all
    # @cart = CartItem.of_cart(current_user.id)
    # @cart = CartItem.where(cart_id: current_user.id)

    @cart = CartItem.all.where(cart_id: current_user.id) # add scope for this
  end

  def destroy
  end
end
