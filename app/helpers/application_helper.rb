module ApplicationHelper
  def attendance_summary_for(student)
    if student.attendances.empty?
      "N/A"
    else
      "#{student.attendances.percent_present}%"
    end
  end
end
