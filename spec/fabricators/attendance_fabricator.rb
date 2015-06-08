Fabricator(:attendance) do
  student
  school_day
  present { true }
end
