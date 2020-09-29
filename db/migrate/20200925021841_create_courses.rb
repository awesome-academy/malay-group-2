class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.datetime :started_at

      t.timestamps null: false
    end
  end
end
