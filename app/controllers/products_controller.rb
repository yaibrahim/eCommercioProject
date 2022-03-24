class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(set_product)
    @product.user_id = current_user.id
    if @product.save
        redirect_to product_path(@product),
        flash[:notice] = 'Product added...'
    else
        render 'new'
    end

  end

  def edit
  end

  def show
  end

  def update
    if @product.update(set_product)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def list
    @your_products = Product.all.where(user_id: current_user.id)
  end

  private

  def set_product
    params.require(:product).permit(:name, :serial_number, :price, :description)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
