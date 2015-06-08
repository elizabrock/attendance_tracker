class Attendance < ActiveRecord::Base
  belongs_to :student

  validates :date, :student, presence: true
end
