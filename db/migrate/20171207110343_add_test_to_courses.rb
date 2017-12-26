# xzh
class AddTestToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :test, :string
  end
end
