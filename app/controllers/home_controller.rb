# frozen_string_literal: true
class HomeController < ApplicationController
  def index
  end

  def search
    @results = Product.with_name_like(params[:search])
  end
end
