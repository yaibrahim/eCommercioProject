class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      redirect_to products_path
      flash[:notice] = 'Successfully added to cart...'
    end

  end

  def new
    @cart_item = CartItem.new
  end

  def destroy
    puts request.format
    @cart_item = CartItem.find(params[:id]) # callback me likhna ye
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
  end
end
