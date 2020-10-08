class RegistersController < ApplicationController
  before_action :set_course
  before_action :set_register, only: %i(edit update)
  before_action :load_user, only: %i(new edit update)

  def new
    @register = Register.new
  end

  def create
    @register = @course.registers.build register_params.merge(user_id: current_user.id)
    if @register.save
      flash[:info] = t "controllers.registers.create.create_success"
      redirect_to current_user
    else
      flash.now[:danger] = t "controllers.registers.create.create_fail"
      render :new
    end
  end

  def edit; end

 def update
    if @register.update register_params
      redirect_to current_user
      flash[:success] = t "controllers.reviews.update_success"
    else
      flash.now[:danger] = t "controllers.reviews.update_fail"
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:warning] = t "controllers.courses.not_found"
    redirect_to courses_path
  end

  def register_params
    params.require(:register).permit :name, :email, :status  
  end

  def load_user
    @user = User.find_by id: params[:user_id] 
  end

  def set_register
    @register = Register.find_by id: params[:id]
    return if @register

    flash[:warning] = t "controllers.registers.not_found"
    redirect_to courses_path
  end
end
