class CoursesController < ApplicationController
  before_action :set_course, except: %i(new create show)
  before_action :check_permitted_or_not, only: %i(edit destroy)

  def new
    @course = Course.new
  end

  def index
    @course = Course.recent_courses.page(params[:page]).per Settings.default_page.courses
  end

  def show
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t "controllers.courses.not_found"
    redirect_to courses_path
  end

  def edit; end

  def create
    @course = Course.new course_params

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: t("controllers.courses.create") }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end 

  def update
    respond_to do |format|
      if @course.update course_params
        format.html { redirect_to @course, notice: t("controllers.courses.updated") }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @course.destroy
        format.html { redirect_to courses_path, notice: t("controllers.courses.destroy") }
        format.json { head :no_content }
      else
        format.html {redirect_to courses_path, notice: t("controllers.courses.not_destroy")}
        format.json { head :no_content }
      end
    end
  end

  private

  def course_params
    params.require(:course).permit :title, :description, :started_at, :member, :status, :total_month
  end

  def set_course
    @course = Course.find_by id: params[:id]
  end

  def check_permitted_or_not
    return unless current_user.is_admin?
    flash[:danger] = "You dont have permission"
    redirect_to courses_path
  end
end
