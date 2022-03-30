class HomeController < ApplicationController
  def index
  end

  def search
    @product_search = Product.where("name LIKE ?","%" + params[:search] + "%")
  end
end
