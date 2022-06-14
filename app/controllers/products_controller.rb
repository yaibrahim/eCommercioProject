class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :edit]

  def index
    @products = Product.order(:id).paginate(page: params[:page], per_page: 15)
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    @product.pimage.attach(params[:product][:pimage])

    if @product.save
      redirect_to product_path(@product), notice: 'Product added...'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def show
  end

  def update
    if @product.update(product_params)
      @product.pimage.attach(params[:product][:pimage])
      redirect_to @product
    else
      render :edit
    end
  end

  def list
    @my_products = current_user.products.paginate(page: params[:page], per_page: 12)
  end

  def search
    unless params[:search].present?
      flash[:alert] = 'Search field must be filled'
      redirect_back(fallback_location: root_path)
    else
      @search_result = Product.with_name_like(params[:search])
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :serial_number, :price, :description, :pimage)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to products_path, notice: 'Product not found'
    end
  end
end
