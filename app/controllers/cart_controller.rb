class CartController < ApplicationController
  # before_action :authenticate_user!
  def index
    if current_user.present?
      if session[:cart].present?
        user_cart_items.delete_all
        session[:cart].each_with_index do |cart_item, i|
          add_guest_cart_items(session[:cart][i]['product_id'], session[:cart][i]['quantity'])
        end
        @cart = user_cart_items
        session[:cart] = []
      else
        @cart = user_cart_items
      end
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

  private

  def add_guest_cart_items(product_id, quantity)
    CartItem.create('product_id': product_id, 'quantity': quantity, cart_id: current_user.cart.id)
  end

  def user_cart_items
    CartItem.user_cart(current_user.cart.id)
  end
end
