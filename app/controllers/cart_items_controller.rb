class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:edit, :destroy, :update]
  def create
    @cart_item = CartItem.new(cart_item_params)
    if CartItem.item_existence(@cart_item[:product_id])
      check = CartItem.get_existed_product_quantity(@cart_item[:product_id])
      if check == true
        old_quantity = CartItem.where(product_id: @cart_item[:product_id])[0].quantity
        new_quantity = (old_quantity + @cart_item[:quantity])
        @cart_item = CartItem.find_product(@cart_item[:product_id])
        @cart_item.quantity = new_quantity
      end
      if @cart_item.save
        # puts @cart_item.quantity
        redirect_to products_path
        flash[:alert] = 'Cart Updated'
      else
        redirect_to products_path
        flash[:alert] = 'There is some problem'
      end

    else

      if @cart_item.save
        redirect_to products_path
        flash[:notice] = 'Successfully added to cart...'
      else
        redirect_to products_path
        flash[:alert] = 'There is some issue...'
      end
    end
  end

  def new
    @cart_item = CartItem.new
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def destroy
    byebug
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Item was successfully deleted.' }
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
