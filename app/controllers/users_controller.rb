class UsersController < ApplicationController
  before_action :set_user, expect: %i(new create index)
  before_action :authenticate_user! , only: %i(edit update destroy)
  before_action :check_permitted_or_not , only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.order(:name).page(params[:page]).per Settings.default_page.users
  end
  
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "controllers.users.user_not_found"
    redirect_to root_path
  end

  def edit; end

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

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t("controllers.users.update") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: t("controllers.users.delete") }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, notice: t("controllers.users.not_delete")}
        format.json { head :no_content }
      end  
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def set_user
    @user = User.find_by id: params[:id]
    return if @user
  end

  def check_permitted_or_not
    if @user.id != current_user.id
      redirect_to users_path
    end
  end

  def authenticate_user!
    if @user
      session[:user_id] = @user.id
    else
      render json: { status: 401 }
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
