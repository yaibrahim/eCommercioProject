class ReviewsController < ApplicationController
before_action :set_review, only: [:edit, :update, :destroy]
before_action :authenticate_user!

  def index
    @reviews = current_user.reviews.paginate(page: params[:page], per_page: 10)
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to product_path(@review.product_id)
      flash[:notice] = 'review added...'
    else
      flash[:notice] = 'There is some problem..'
    end
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
    if params[:product_id].present? && params[:id].present?
      @review.destroy
      redirect_to products_url, notice: 'Reviews was successfully destroyed.'
    else
      redirect_to products_url, alert: @review.errors.full_messages.to_sentence
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
