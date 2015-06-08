class HomeController < ApplicationController
  def index
    @students = Student.all.sort do |a, b|
      if a.attendances.percent_present == b.attendances.percent_present
        a.name <=> b.name
      else
        (a.attendances.percent_present <=> b.attendances.percent_present) * -1
      end
    end
  end
end
