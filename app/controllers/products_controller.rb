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
    @product.serial_number = serial_number_generator.upcase
    if @product.save
      redirect_to product_path(@product)
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

  def serial_number_generator
    numeric = '0123456789'
    alphabets_small = 'abcdefghijklmnopqrstuvwxyz'
    password_items = numeric + alphabets_small
    pass = ''
    index = 0
    while index < 10
      rand_value = rand 0..password_items.length - 1
      pass += password_items[rand_value]
      index += 1
    end
    return pass
  end

end
