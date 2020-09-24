class UsersController < ApplicationController
  def index; end
  
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "controllers.users.user_not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controllers.users.please_check_activate"
      redirect_to root_url
    else
      flash[:danger] = t "controllers.users.acc_reg_failed"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
