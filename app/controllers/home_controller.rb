class HomeController < ApplicationController
  def index
    @students = Student.all_by_attendance
  end
end
