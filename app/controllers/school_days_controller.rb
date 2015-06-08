class SchoolDaysController < ApplicationController
  def new
    @school_day = SchoolDay.for(Date.today)
  end
end
