class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:edit, :destroy, :update]

  def new
    @cart_item = CartItem.new
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if CartItem.product_exists(@cart_item[:product_id])

      if CartItem.get_existed_product_quantity(@cart_item[:product_id])
        old_quantity = CartItem.where(product_id: @cart_item[:product_id])[0].quantity
        new_quantity = (old_quantity + @cart_item[:quantity])
        @cart_item = CartItem.find_product(@cart_item[:product_id])
        @cart_item.quantity = new_quantity

      elsif @cart_item.save
        redirect_to products_path, alert: 'Cart Updated'
      else
        redirect_to products_path, alert: 'There is some problem'
      end

    else
      redirect_to products_path, notice: 'Cart is Updated...'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
