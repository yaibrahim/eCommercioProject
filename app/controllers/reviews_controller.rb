class ReviewsController < ApplicationController
before_action :set_review, only: [:show, :edit, :update, :destroy]
before_action :require_login, only: [:edit]
before_action :require_user_edit, only: [:edit, :update]

  def index
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to product_review_path(@review.product_id, @review)
      flash[:notice] = 'review added...'
    else
      flash[:notice] = 'There is some problem..'
    end

  end

  def show
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

  def list
    # this is better.
    @reviews = current_user.reviews
    # @reviews = Review.all_reviews(current_user.id)
  end

  def destroy
    puts request.format

    @review.destroy

    # what if review doesnt get destroyed for some reason?? we are not handling the errors here
    redirect_to products_url, notice: 'Reviews was successfully destroyed.'
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :product_id, :review_message)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def require_user_edit # same as in products controller
    if @review.user_id != current_user.id
      flash[:alert] = "You can't edit or update others review.."
      redirect_to products_path
    end
  end

  def require_login # same as in products controller
    if !current_user.present?
      flash[:notice] = "You can't edit someones review required login"
      redirect_to products_path
    end
  end
end
