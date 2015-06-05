feature "Homepage displays attendance leaderboard" do
  scenario "when there are no students" do
    visit root_path
    page.should have_content("Attendance Leaderboard")
    page.should have_content("There are currently no students in the system")
  end
  scenario "when no attendance data has been recorded"
  scenario "when there are stats to display"
end
