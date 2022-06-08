class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:edit, :destroy, :update]

  def new
    @cart_item = CartItem.new
  end

  def create
    byebug
    @cart_item = CartItem.new(cart_item_params)
    if CartItem.product_exists?(@cart_item.cart_id, @cart_item.product_id)
      product = CartItem.find_product(@cart_item.cart_id, @cart_item.product_id)
      new_quantity = product.quantity + @cart_item.quantity
      product.update(quantity: new_quantity)

      redirect_to products_path, alert: 'Cart Updated' if product.save
    else
      if @cart_item.save
        redirect_to products_path, alert: 'Product Added to Cart'
      else
        redirect_to products_path, alert: @cart_item.errors.full_messages.to_sentence
      end
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
