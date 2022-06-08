class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:edit, :destroy, :update]

  def create
    @cart_item = CartItem.new(cart_item_params)

    # https://dev.to/katkelly/active-record-find-vs-findby-vs-where-3b9e
    # https://www.theodinproject.com/lessons/ruby-on-rails-active-record-queries

    # these two articles are super important for you.

    # if CartItem.product_exists?(@cart_item[:product_id]) is better
    if CartItem.item_existence(@cart_item[:product_id])
      # the following code is dirty. please try to revise this on your own.
      check = CartItem.get_existed_product_quantity(@cart_item[:product_id])

      if check == true
        old_quantity = CartItem.where(product_id: @cart_item[:product_id])[0].quantity
        new_quantity = (old_quantity + @cart_item[:quantity])
        @cart_item = CartItem.find_product(@cart_item[:product_id])
        @cart_item.quantity = new_quantity
      end

      # line # 25-31 and 35-41 are somewhat similar. we can minimize the code here by keeping this block after the block of line # 13
      if @cart_item.save
        # puts @cart_item.quantity
        redirect_to products_path, alert: 'Cart Updated'

      else
        redirect_to products_path, alert: 'There is some problem'
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
