class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :theme
      t.string :content
      t.string :publish_time
      t.string :course_name
      t.belongs_to :course

      t.timestamps null: false
    end
  end
end
