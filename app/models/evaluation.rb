#sgg7
class Evaluation < ActiveRecord::Base
	belongs_to :course
	belongs_to :user
end
