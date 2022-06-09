class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :edit]
  before_action :authenticate_user!, only: [:edit]
  before_action :authorize_product_owner, only: [:edit, :update]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to product_path(@product), notice: 'Product added...'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def list
    @my_products = current_user.products
  end

  def search
    @search_result = Product.with_name_like(params[:search])
  end

  private

  def product_params
    params.require(:product).permit(:name, :serial_number, :price, :description)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to products_path, notice: 'Product not found'
    end
  end

  def edit_set_product
    @product = current_user.products.find(params[:id])
  end

  def authorize_product_owner
    if @product.not_an_owner? current_user.id
      redirect_to products_path, notice: "You can't edit someones product"
    end
  end

  def authenticate_user
    unless current_user.present?
      flash[:notice] = 'You need to login to perform any action.'
      redirect_to products_path
    end
  end
end
