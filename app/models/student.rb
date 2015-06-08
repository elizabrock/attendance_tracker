class Student < ActiveRecord::Base
  has_many :attendances

  validates :name, presence: true, uniqueness: true

  default_scope ->{ order(:name) }

  def self.all_by_attendance
    Student.all.sort do |a, b|
      if a.attendances.percent_present == b.attendances.percent_present
        a.name <=> b.name
      else
        (a.attendances.percent_present <=> b.attendances.percent_present) * -1
      end
    end
  end
end
