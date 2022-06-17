class ReviewsController < ApplicationController
before_action :set_review, only: [:edit, :update, :destroy]
before_action :authenticate_user!

  def index
    @reviews = current_user.reviews.paginate(page: params[:page], per_page: 10)
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.product_id = params[:product_id]
    @review.save
    redirect_back(fallback_location: root_path, notice: 'review added...')
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to list_reviews_path, notice: 'Review was successfully updated.'
    else
      render :list, status: 422
    end
  end

  def destroy
    product = @review.product_id
    if @review.destroy
      respond_to do |format|
        format.html { redirect_to product_path(product) }
        format.json { head :no_content }
        format.js   { render layout: false }
      end
    else
      redirect_to products_url, alert: 'Your Review not deleted yet, please try again..'
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :product_id, :review_message)
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    authorize @review
    if @review.nil?
      redirect_to products_path, notice: 'Review not found'
    end
  end
end
