class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:coursedetails,:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
    puts "+++++++++++++++++++++++++++++"
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {info: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    @course.update_attributes(student_num: 0)
    redirect_to courses_path, flash: {:info => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    redirect_to courses_path, flash: {:info => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:info => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #sgg22
  def feedback_index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
  end
  #sgg22 end

   def studentlist
    @course=Course.find_by_id(params[:id])
    @grade=Grade.where(:course_id => params[:id]).paginate(page: params[:page], per_page: 8) 
    tmp=[]
    @grade.each do |grade|
      tmp<<User.find_by_id(grade.user_id)
    end
    @department = tmp
  end
  #-------------------------for students----------------------

  def list
    #-------QiaoCode--------
    puts "7777777777777777777777777"
    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 8) 
    puts @courses.length
    puts "7777777777777777777777777"
    @course = @courses - current_user.courses
    tmp=[]
    @course.each do |course|
      if course.open==true
        tmp<<course
      end
    end
    @course=tmp
    puts "8888888888"
    puts @course.length

    # @grade=Grade.where(:course_id => params[:id],:user_id=>current_user.id).first

    @all_statuses = [["所有", "所有"],["一级学科核心课", "一级学科核心课"],["专业核心课", "专业核心课"], ["专业研讨课", "专业研讨课"],["专业普及课", "专业普及课"],["公共选修课", "公共选修课"]]
    @tmp_status = params[:status]
    @selectcourse = params[:search]
    if !@selectcourse.blank?

        if @tmp_status != "所有"
           puts "3333333333333333333333"
           @course = Course.where("name LIKE '%#{@selectcourse}%' ").all - current_user.courses
           tmp=[]
           @course.each do |course|
               if course.open==true && course.course_type == @tmp_status
                    tmp<<course
               end
           end
           @course=tmp
        else
          puts "44444444444444444444444"
           @course = Course.where("name LIKE '%#{@selectcourse}%' ").all - current_user.courses
           tmp=[]
           @course.each do |course|
           if course.open==true
               tmp<<course
           end
           end
          @course=tmp
        end
    else

      if @tmp_status.nil? or @tmp_status == "" or @tmp_status == "所有"
        puts "99999999999999999"
        @course = @courses - current_user.courses
        tmp=[]
        @course.each do |course|
          if course.open==true
            tmp<<course
          end
        end
        @course=tmp
      elsif


       @tmp_status != "所有"
       puts "55555555555555555"

       tmp=[]
       @course.each do |course|
        if course.open==true && course.course_type == @tmp_status
          tmp<<course
        end
      end
      @course=tmp


    end
    end
  end

  def select        #xzh
    @course=Course.find_by_id(params[:id])  
    
    tmp=[]
    @alltime = current_user.courses
    @alltime.each do |alltime|
        tmp<<alltime.course_time
    end

    k = 0 
    for i in 0..tmp.size-1 do  
      if @course.course_time[0..1] == tmp[i][0..1]
          a = @course.course_time[3].to_i 
          if @course.course_time.size == 7 
              b =  @course.course_time[5].to_i
          else 
              b =  @course.course_time[5..6].to_i
          end
          c = tmp[i][3].to_i 
          if tmp[i].size == 7 
              d =  tmp[i][5].to_i
          else 
              d =  tmp[i][5..6].to_i
          end
          if a == c
             k += 1
          elsif a<c && c<=b
             k += 1
          elsif a>c && a<=d
             k += 1
          end    
      end
    end
    if k != 0
        flash={:info => "#{@course.name}  与已选课程时间冲突"}
        redirect_to list_courses_path, flash: flash
    else
    tmp = 0
    tmp = @course.student_num
    tmp += 1  
    @course.update_attributes(student_num: tmp) 
    current_user.courses<<@course
    

    @grade=Grade.where(:course_id => params[:id],:user_id=>current_user.id).first
    @grade.update_attributes(degree: 0)

    @course.update_attributes(test: "否")
    if params[:dc] == "1"
      @course.update_attributes(test: "是") 
      @grade.update_attributes(degree: 1)        
    end

    flash={:info => "成功选择课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
    end
  end

  def quit    #xzh
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)   
    tmp = 0
    tmp = @course.student_num
    tmp -= 1 
    @course.update_attributes(student_num: tmp) 
    flash={:info => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  def totalcredit    #xzh
    @course=current_user.courses
    tmp = []
    @course.each do |course|
       tmp<<Grade.where(:course_id => course.id,:user_id=>current_user.id).first
    end 
    @grade = tmp
  end 
 
  def coursedetails
    @course=Course.find_by_id(params[:id])
    @grade=Grade.where(:course_id => params[:id],:user_id=>current_user.id).first
  end

  def st
    @course=current_user.courses if student_logged_in?
  end

  #sgg3
  def evaluation_index
    @course=current_user.courses.paginate(page: params[:page], per_page: 4) if student_logged_in?
  end
  #sgg3 end


 

  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
    
    if student_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 4)

    # tmp=[]
    # @course.each do |course|
    #   if course.open==true
    #     tmp<<course
    #   end
    # end
    # @course=tmp

    tmp = []
    @course.each do |course|
       tmp<<Grade.where(:course_id => course.id,:user_id=>current_user.id).first
    end 
    @grade = tmp
    end
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

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week)
  end


end
