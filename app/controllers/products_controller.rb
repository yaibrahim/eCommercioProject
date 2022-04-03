class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :edit]
  #before_action :edit_set_product, only: [:edit]
  before_action :require_user_edit, only: [:edit, :update]

  #include ProductsHelper

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to product_path(@product)
      flash[:notice] = 'Product added...'
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
    @your_products = current_user.products
  end

  def search
    if params[:search] == params[:search].capitalize
      @search_result = Product.where("name LIKE ?","%" + params[:search].capitalize + "%")
    else
      @search_result = Product.where("name LIKE ?","%" + params[:search] + "%")
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :serial_number, :price, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def edit_set_product
    @product = current_user.products.find(params[:id])
  end

  def require_user_edit
    if @product.user_id != current_user.id
      flash[:notice] = "You can't edit someones product"
      redirect_to products_path
    end
  end

end
