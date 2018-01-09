class NoticesController < ApplicationController

  # before_action :student_logged_in
  # before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy]#add open by qiao
  # before_action :logged_in, only: :check

  #-------------------------for teachers----------------------
 

  def new
    @notice=Notice.new
  end


  def create
    @notice = Notice.new(notice_params)
    @notice.course_name = Course.find_by_id(@notice.course_id).name
    if @notice.save

      redirect_to notices_path, flash: {info: "新通知已发布"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @notice=Notice.find_by_id(params[:id])
  end

  def update
    @notice = Notice.find_by_id(params[:id])
    if @notice.update_attributes(notice_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to notices_path, flash: flash
  end

    def destroy
    @notice=Notice.find_by_id(params[:id])
    # current_user.teaching_courses.delete(@notice)
    @notice.destroy
    flash={:info => "成功删除课程通知: #{@notice.theme}"}
    redirect_to notices_path, flash: flash
  end


#---------------------for both teachers and students-------------------
 def index
  if params[:q].nil? or params[:q]==""
      if teacher_logged_in?
        @courses=current_user.teaching_courses
        tmp=[]
        @courses.each do |course|
          @notices=course.notices
          @notices.each do |notice|
            tmp<<notice
          end
        end
        @notice=tmp
      elsif student_logged_in?
        @courses=current_user.courses
        tmp=[]
        @courses.each do |course|
          @notices=course.notices
          @notices.each do |notice|
            tmp<<notice
          end
        end
        @notice=tmp
      else
        redirect_to root_path, flash: {:warning=>"请先登陆"}
      end
  else
      @courses1=Course.where("name LIKE '%#{params[:q]}%'").all
      if teacher_logged_in?
        @courses2=current_user.teaching_courses
        @courses=@courses1&@courses2
        tmp=[]
        @courses.each do |course|
          @notices=course.notices
          @notices.each do |notice|
            tmp<<notice
          end
        end
        @notice=tmp
      elsif student_logged_in?
        @courses2=current_user.courses
         @courses=@courses1&@courses2
        tmp=[]
        @courses.each do |course|
          @notices=course.notices
          @notices.each do |notice|
            tmp<<notice
          end
        end
        @notice=tmp
      end
  end
  end

  def check
    @notice=Notice.find_by_id(params[:id])
  end

  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def notice_params
    params.require(:notice).permit(:course_id,:publish_time,:theme, :content)
  end

end
