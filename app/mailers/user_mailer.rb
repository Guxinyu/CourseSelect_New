class UserMailer < ApplicationMailer

	default from: "jingyucourseselect@163.com"
  def notify(student,notice)

    @notice = notice

    pattern = /^[a-zA-Z0-9.-]+@[gmail|qq|163|126|outlook]+.[a-zA-Z.]{2,5}$/

		@user = student
    	if @user.email.match pattern
      	mail to: @user.email, subject: "新课程通知"
      	puts @user.email
      	puts "7777777777777777777777"	
        end
  end
end
