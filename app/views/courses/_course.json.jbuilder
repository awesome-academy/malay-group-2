json.extract! course, :id, :title, :created_at, :updated_at
json.url courses_url(course, format: :json)
