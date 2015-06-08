class Attendance < ActiveRecord::Base
  belongs_to :student

  validates :date, :student, presence: true

  scope :percent_present, -> { average('CAST(present AS int) * 100').to_i }
end
