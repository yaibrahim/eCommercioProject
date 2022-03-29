class HomeController < ApplicationController
  def index
  end

  def search
    byebug
    @product_search = Product.where("name LIKE ?","%" + params[:search] + "%")
  end
end
