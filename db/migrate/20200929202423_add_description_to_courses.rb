class AddDescriptionToCourses < ActiveRecord::Migration[6.0]
  def change
  	add_column :courses, :description, :text
  	add_column :courses, :started_at, :datetime
  end
end
