class EvaluationsController < ApplicationController
	#sgg10
	def edit
	  @course=Course.find_by_id(params[:id])
	end 
	#sgg11
	def insert
        @course=Course.find_by_id(params[:id])

		if params[:score1].nil? or params[:score2].nil? or params[:score3].nil? or params[:score4].nil? or params[:score5].nil? or params[:score6].nil? or params[:score7].nil? or params[:score8].nil?
            flash[:danger] = "信息填写不全,请填写完整后再保存!"
            redirect_to edit_evaluation_url(@course)
        else 
            insert_record(current_user.id,@course.id,1,params[:score1].to_i)
            insert_record(current_user.id,@course.id,2,params[:score2].to_i)
            insert_record(current_user.id,@course.id,3,params[:score3].to_i)
            insert_record(current_user.id,@course.id,4,params[:score4].to_i)
            insert_record(current_user.id,@course.id,5,params[:score5].to_i)
            insert_record(current_user.id,@course.id,6,params[:score6].to_i)
            insert_record(current_user.id,@course.id,7,params[:score7].to_i)
            insert_record(current_user.id,@course.id,8,params[:score8].to_i)

            flash[:info] = "评估成功!"
            redirect_to evaluation_index_courses_path
		end

	end

	#sgg12
	def insert_record(user_id,course_id,item,score)
        evaluation1=Evaluation.where(:user_id=>user_id,:course_id=>course_id,:item=>item).first
        if evaluation1.nil? 
          evaluation1=Evaluation.new
		      evaluation1.user_id=user_id
          evaluation1.course_id=course_id
          evaluation1.item=item
          evaluation1.score=score
          evaluation1.save                                           
        else
          evaluation1.update_attributes(:score=>score)
        end		
	end

  #sgg14  admin evaluation index page
  def index
    @selectcontent=params[:selectcontent]
    if @selectcontent.nil? || @selectcontent.empty?
      @courses = Course.all.order("id ASC").paginate(page: params[:page], per_page: 8)
    else
      @courses = Course.where(" name LIKE '%#{@selectcontent}%' ").all.paginate(page: params[:page], per_page: 4)
    end

  end

  #nskk1
  def items
    @evaluationitems=Evaluationitem.all.order("id ASC");
  end

  #nskk3
  def itemupdate
    if params[:evaluationitem][:itemcontent].nil? or params[:evaluationitem][:itemcontent]=="" or params[:evaluationitem][:itemcontent].lstrip==""
      redirect_to items_evaluations_path, flash: {:danger => "评估项不能为空!"}
    else
      @Evaluationitem=Evaluationitem.find_by_id(params[:id])
      @Evaluationitem.update_attributes(:itemcontent=>params[:evaluationitem][:itemcontent])
      redirect_to items_evaluations_path,flash: {info: "修改评估项成功!"}
    end
  end

  #nskk4
  def itemdelete
    @Evaluationitem=Evaluationitem.find_by_id(params[:id])
    @Evaluationitem.destroy
    redirect_to items_evaluations_path, flash: {:info => "成功删除!"}
  end

  #nskk5
  def itemadd
    if params[:itemcontent].nil? or params[:itemcontent]=="" or params[:itemcontent].lstrip==""
      redirect_to items_evaluations_path, flash: {:danger => "评估项不能为空!"}
    else
      addevaluationitem=Evaluationitem.new
      addevaluationitem.itemcontent= params[:itemcontent]
      addevaluationitem.save 
      redirect_to items_evaluations_path, flash: {:info => "成功增加评估项!"}
    end
  end

  #sgg15
  def result
    @course=Course.find_by_id(params[:id])

    @label11=getLabelForItem(@course.id,1,1)
    @label12=getLabelForItem(@course.id,1,2)
    @label13=getLabelForItem(@course.id,1,3)
    @label14=getLabelForItem(@course.id,1,4)

    @label21=getLabelForItem(@course.id,2,1)
    @label22=getLabelForItem(@course.id,2,2)
    @label23=getLabelForItem(@course.id,2,3)
    @label24=getLabelForItem(@course.id,2,4)

    @label31=getLabelForItem(@course.id,3,1)
    @label32=getLabelForItem(@course.id,3,2)
    @label33=getLabelForItem(@course.id,3,3)
    @label34=getLabelForItem(@course.id,3,4)

    @label41=getLabelForItem(@course.id,4,1)
    @label42=getLabelForItem(@course.id,4,2)
    @label43=getLabelForItem(@course.id,4,3)
    @label44=getLabelForItem(@course.id,4,4)

    @label51=getLabelForItem(@course.id,5,1)
    @label52=getLabelForItem(@course.id,5,2)
    @label53=getLabelForItem(@course.id,5,3)
    @label54=getLabelForItem(@course.id,5,4)

    @label61=getLabelForItem(@course.id,6,1)
    @label62=getLabelForItem(@course.id,6,2)
    @label63=getLabelForItem(@course.id,6,3)
    @label64=getLabelForItem(@course.id,6,4)

    @label71=getLabelForItem(@course.id,7,1)
    @label72=getLabelForItem(@course.id,7,2)
    @label73=getLabelForItem(@course.id,7,3)
    @label74=getLabelForItem(@course.id,7,4)

    @label81=getLabelForItem(@course.id,8,1)
    @label82=getLabelForItem(@course.id,8,2)
    @label83=getLabelForItem(@course.id,8,3)
    @label84=getLabelForItem(@course.id,8,4)

    @results=getNumForItem(@course.id,8)


  end

  #sgg16
  def getLabelForItem(course_id,item,score)
    num1=Evaluation.where(:course_id=>course_id,:item=>item,:score=>1).count
    num2=Evaluation.where(:course_id=>course_id,:item=>item,:score=>2).count
    num3=Evaluation.where(:course_id=>course_id,:item=>item,:score=>3).count
    num4=Evaluation.where(:course_id=>course_id,:item=>item,:score=>4).count
    count=num1+num2+num3+num4
    

    if count==0
      label="  得票数 0   0%"
    else
      if score==1
        percent=format("%.2f",format("%.4f",num1.to_f/count).to_f*100)
        label="  得票数 #{num1}   #{percent}%"
      end
      if score==2
        percent=format("%.2f",format("%.4f",num2.to_f/count).to_f*100)
        label="  得票数 #{num2}   #{percent}%"
      end
      if score==3
        percent=format("%.2f",format("%.4f",num3.to_f/count).to_f*100)
        label="  得票数 #{num3}   #{percent}%"
      end
      if score==4
        percent=format("%.2f",format("%.4f",num4.to_f/count).to_f*100)
        label="  得票数 #{num4}   #{percent}%"
      end
    end

    return label
  end

  #sgg19
  def getNumForItem(course_id,item)
    num1=Evaluation.where(:course_id=>course_id,:item=>item,:score=>1).count
    num2=Evaluation.where(:course_id=>course_id,:item=>item,:score=>2).count
    num3=Evaluation.where(:course_id=>course_id,:item=>item,:score=>3).count
    num4=Evaluation.where(:course_id=>course_id,:item=>item,:score=>4).count
    count=num1+num2+num3+num4
    
    if count==0
      result=[10000,10000,10000,10000]
    else
      result=[num1,num2,num3,num4]
    end

    return result
  end

  #sgg25
  def openfeedback
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(:isopen=>"1")
    redirect_to evaluations_path,flash: {info: "开通教师查看权限成功!"}
  end 

  def closefeedback
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(:isopen=>"0")
    redirect_to evaluations_path,flash: {info: "关闭教师查看权限成功!"}
  end
end
