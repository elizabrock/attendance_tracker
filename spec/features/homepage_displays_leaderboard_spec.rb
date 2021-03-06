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

  scenario "when there are stats to display" do
    three = Fabricate(:school_day, date: 3.days.ago)
    two = Fabricate(:school_day, date: 2.days.ago)
    one = Fabricate(:school_day, date: 1.days.ago)
    bob = Fabricate(:student, name: "Bob") # 100%
    Fabricate(:attendance, student: bob, school_day: three, present: true)
    Fabricate(:attendance, student: bob, school_day: two, present: true)
    Fabricate(:attendance, student: bob, school_day: one, present: true)
    sally = Fabricate(:student, name: "Sally") # 100%
    Fabricate(:attendance, student: sally, school_day: three, present: true)
    Fabricate(:attendance, student: sally, school_day: two, present: true)
    Fabricate(:attendance, student: sally, school_day: one, present: true)
    joe = Fabricate(:student, name: "Joe") # 33%
    Fabricate(:attendance, student: joe, school_day: three, present: false)
    Fabricate(:attendance, student: joe, school_day: two, present: true)
    Fabricate(:attendance, student: joe, school_day: one, present: false)
    amanda = Fabricate(:student, name: "Amanda") # 66%
    Fabricate(:attendance, student: amanda, school_day: three, present: true)
    Fabricate(:attendance, student: amanda, school_day: two, present: true)
    Fabricate(:attendance, student: amanda, school_day: one, present: false)
    martha = Fabricate(:student, name: "Martha") # 100%
    Fabricate(:attendance, student: martha, school_day: one, present: true)
    Fabricate(:student, name: "Scott")
    visit root_path
    page.should_not have_content("There are currently no students in the system")
    within("table#leader_board tbody") do
      within("tr:nth-child(1)") do
        page.should have_content("Bob")
        page.should have_content("100%")
      end
      within("tr:nth-child(2)") do
        page.should have_content("Martha")
        page.should have_content("100%")
      end
      within("tr:nth-child(3)") do
        page.should have_content("Sally")
        page.should have_content("100%")
      end
      within("tr:nth-child(4)") do
        page.should have_content("Amanda")
        page.should have_content("66%")
      end
      within("tr:nth-child(5)") do
        page.should have_content("Joe")
        page.should have_content("33%")
      end
      within("tr:nth-child(6)") do
        page.should have_content("Scott")
        page.should have_content("N/A")
      end
    end
  end
end
