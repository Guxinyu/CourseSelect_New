class AddIsOpenToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :isopen, :string
  end
end
