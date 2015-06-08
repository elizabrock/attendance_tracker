Fabricator(:attendance) do
  student
  date { Date.today }
  present { true }
end
