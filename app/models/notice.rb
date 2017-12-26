class Notice < ActiveRecord::Base
	  belongs_to :course, class_name: "Course"

	  validates :theme, presence: true
	  validates :content, presence: true
	  validates :course_name, presence: true
end
