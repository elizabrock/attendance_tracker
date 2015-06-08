class Attendance < ActiveRecord::Base
  belongs_to :school_day
  belongs_to :student

  validates :school_day, :student, presence: true

  scope :percent_present, -> { average('CAST(present AS int) * 100').to_i }
end
