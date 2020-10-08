class Course < ApplicationRecord
  enum status: { opening: 0, started: 1, finished: 2 }

  scope :recent_courses, ->{order created_at: :desc}

  after_initialize do
    self.status ||= :opening if self.new_record?
  end

  validates :title, presence: true, length:{ maximum: Settings.validations.course.max_length }
  validates_uniqueness_of :title

  has_many :courses
  has_many :reviews, dependent: :destroy
  has_many :registers, dependent: :destroy
end
