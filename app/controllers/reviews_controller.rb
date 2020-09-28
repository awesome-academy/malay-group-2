class ReviewsController < ApplicationController
  before_action :find_course
  before_action :find_review, only: %(edit update destroy)

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    @review.course_id = @course.id
    @review.user_id = current_user.id
    if @review.save
  	  redirect_to user_path
    else
  	  render :new
    end
  end
  
  def edit; end
  
  def update
    if @review.update(review_params)
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to course_path(@course)
  end

  private

  def review_params
    params.require(:review).permit :comment
  end	
  
  def find_course
    @course = Course.find_by id: params [:course_id]
  end

  def find_review
    @review = Review.find_by id: params [:id]
  end
end
