feature "Homepage displays attendance leaderboard" do
  scenario "when there are no students" do
    visit root_path
    page.should have_content("Attendance Leaderboard")
    page.should have_content("There are currently no students in the system")
    page.should_not have_css("table#leader_board")
  end
  scenario "when no attendance data has been recorded" do
    Fabricate(:student, name: "Bob")
    Fabricate(:student, name: "Sally")
    Fabricate(:student, name: "Joe")
    Fabricate(:student, name: "Amanda")
    visit root_path
    page.should_not have_content("There are currently no students in the system")
    within("table#leader_board tbody") do
      within("tr:nth-child(1)") do
        page.should have_content("Amanda")
        page.should have_content("N/A")
      end
      within("tr:nth-child(2)") do
        page.should have_content("Bob")
        page.should have_content("N/A")
      end
      within("tr:nth-child(3)") do
        page.should have_content("Joe")
        page.should have_content("N/A")
      end
      within("tr:nth-child(4)") do
        page.should have_content("Sally")
        page.should have_content("N/A")
      end
    end
  end

  scenario "when there are stats to display"
end
