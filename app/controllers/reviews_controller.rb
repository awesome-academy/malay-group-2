class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    @review.user_id = current_user.id
    if @review.save
  	  redirect_to user_path
    else
  	  render :new
    end
  end

  private

  def review_params
    params.require(:review).permit :comment
  end	
end
