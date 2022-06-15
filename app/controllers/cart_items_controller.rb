class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:edit, :destroy, :update]

  def new
    @cart_item = CartItem.new
  end

  def create
    if current_user.nil?
      guest_cart
      return
    end
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.cart_id = current_user.cart.id
    authorize @cart_item
    if CartItem.product_exists?(@cart_item.cart_id, @cart_item.product_id)
      product = CartItem.find_product(@cart_item.cart_id, @cart_item.product_id)
      new_quantity = product.quantity + @cart_item.quantity
      product.update(quantity: new_quantity)
      redirect_to products_path, alert: 'Cart Updated'
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
      format.html { redirect_to cart_index_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def guest_cart
    session[:cart] ||= []
    item = { 'quantity': cart_item_params[:quantity], 'product_id': cart_item_params[:product_id] }
    session[:cart].each_with_index do |cart_item, i|
      if session[:cart][i]['product_id'] == item['product_id']
        item[:quantity] = (item[:quantity].to_i + session[:cart][i]['quantity'].to_i).to_s
      end
    end
    session[:cart] << item
    redirect_to products_path, alert: session[:cart]
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
