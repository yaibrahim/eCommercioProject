class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(set_product)
    #@product.user_id = current_user.id
    if @product.save
        format.html { redirect_to product_path(@product), notice: "Product was successfully created." }
        flash[:notice] = 'Product added...'
    else
        format.html { render :new }
    end

  end

  def edit
  end

  def show
  end

  def update
  end

  private

  def set_product
    params.require(:product).permit(:name, :serial_number, :price, :description)
  end

end
