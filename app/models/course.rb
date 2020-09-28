class Course < ApplicationRecord
  enum status: { opening: 0, started: 1, finished: 2 }

  scope :recent_courses, ->{order created_at: :desc}

  after_initialize do
    self.status ||= :opening if self.new_record?
  end

  validates :title, presence: true, length:{ minimum: Settings.validations.course.min_length, maximum: Settings.validations.course.max_length }
  validates_uniqueness_of :title

  belongs_to :user

  has_many :likes
  has_many :users, :through => :likes  
  has_many :reviews
end
