class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :edit]
  before_action :require_login, only: [:edit] # you should use devise provided callback authenticate_user etc
  before_action :require_user_edit, only: [:edit, :update]

  # include ProductsHelper

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
    # @my_products = current_user.products
    # @user_products = current_user.products
    @your_products = current_user.products
  end

  def search
    # can we simplify this condition and use only one block?
    # what if we do only the following? I think we can handle the capitilization in a different way
      # Product.where('name LIKE ?', '%' + params[:search] + '%')

    @search_result = if params[:search] == params[:search].capitalize
      Product.where('name LIKE ?', '%' + params[:search].capitalize + '%')
    else
      Product.where('name LIKE ?', '%' + params[:search] + '%')
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :serial_number, :price, :description)
  end

  def set_product
    # exception handling is missing in this project. Code will break incase end user sends a wrong id
    @product = Product.find(params[:id])
  end

  def edit_set_product
    @product = current_user.products.find(params[:id])
  end

  def require_user_edit # better method name would be def authorize_product_owner
    if @product.user_id != current_user.id # if @product.not_an_owner? current_user.id
      # flash[:notice] = "You can't edit someones product"
      redirect_to products_path, notice: "You can't edit someones product" # one liner
    end

    # owner methods in the product's model would look like the following
    # def owner? current_user_id
    #   self.user_id != current_user_id
    # end

    # def not_an_owner? current_user_id
    #   !owner? current_user_id
    # end
  end

  def require_login # authenticate_user is more appropriate method here.
    # unless current_user?
    if !current_user.present?
      flash[:notice] = "You can't edit someones product required" # this error message is incorrect. It should be 'You need to login to perform any action.'

      redirect_to products_path
    end
  end

end
