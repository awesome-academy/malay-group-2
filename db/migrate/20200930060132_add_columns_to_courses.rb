class AddColumnsToCourses < ActiveRecord::Migration[6.0]
  def change
  	add_column :courses, :total_month, :integer
  	add_column :courses, :status, :integer
  	add_column :courses, :member, :integer
  	add_column :courses, :description, :text
  	add_column :courses, :started_at, :datetime
  end
end
