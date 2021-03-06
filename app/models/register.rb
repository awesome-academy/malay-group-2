class Register < ApplicationRecord
  enum status: { notapply: 0, pending: 1, approved: 2, rejected: 3 }

  belongs_to :course
  belongs_to :user

  scope :recent_registers, ->{order created_at: :desc}

  after_initialize do
    self.status ||= :pending if self.new_record?
  end

  validates :name, presence: true
  validates :email, presence: true
end
