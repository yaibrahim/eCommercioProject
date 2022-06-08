class HomeController < ApplicationController
  def index
  end

  def search
    # scope would be better here.
    # @results = Product.with_name_like(params[:search])

    @product_search = Product.where("name LIKE ?","%" + params[:search] + "%")
  end
end
