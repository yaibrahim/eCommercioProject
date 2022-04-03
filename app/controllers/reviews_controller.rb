class ReviewsController < ApplicationController
before_action :find_review, only: [:show, :edit, :update, :destroy]
before_action :require_user_edit, only: [:edit, :update]

  def index
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(set_review)
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
    respond_to do |format|
      if @review.update(set_review)
        format.html { redirect_to list_reviews_path, notice: 'Review was successfully updated.' }
      else
        format.html { render :list, status: 422 }
      end
    end
  end

  def list
    @reviews = Review.all_reviews(current_user.id)
  end

  def destroy
    puts request.format
    @review.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Reviews was successfully destroyed.' }
    end
  end

  private

  def set_review
    params.require(:review).permit(:user_id, :product_id, :review_message)
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def require_user_edit
    if @review.user_id != current_user.id
      flash[:alert] = "You can't edit or update others review.."
      redirect_to products_path
    end
  end

end
