feature "Entering attendance" do
  scenario "happy path" do
    Fabricate(:student, name: "Bob")
    Fabricate(:student, name: "Sally")
    Fabricate(:student, name: "Joe")
    Fabricate(:student, name: "Amanda")

    visit root_path
    pending
    click_on "Enter Today's Attendance"

    within("table tbody") do
      within("tr:nth-child(1)") do
        page.should have_content("Amanda")
      end
      within("tr:nth-child(2)") do
        page.should have_content("Bob")
      end
      within("tr:nth-child(3)") do
        page.should have_content("Joe")
      end
      within("tr:nth-child(4)") do
        page.should have_content("Sally")
      end
    end

    check "Amanda"
    check "Joe"
    click_on "Save Attendance"

    page.should have_message("Attendance has been saved")

    within("table#leader_board tbody") do
      within("tr:nth-child(1)") do
        page.should have_content("Amanda")
        page.should have_content("100%")
      end
      within("tr:nth-child(2)") do
        page.should have_content("Joe")
        page.should have_content("100%")
      end
      within("tr:nth-child(3)") do
        page.should have_content("Sally")
        page.should have_content("0%")
      end
      within("tr:nth-child(4)") do
        page.should have_content("Bob")
        page.should have_content("0%")
      end
    end

    page.should_not have_content("Enter Today's Attendance")

    Timecop.travel(1.day.from_now) do
      visit root_path
      click "Enter Today's Attendance"

      within("table tbody") do
        within("tr:nth-child(1)") do
          page.should have_content("Amanda")
        end
        within("tr:nth-child(2)") do
          page.should have_content("Bob")
        end
        within("tr:nth-child(3)") do
          page.should have_content("Joe")
        end
        within("tr:nth-child(4)") do
          page.should have_content("Sally")
        end
      end

      Fabricate(:student, name: "Kip")
      check "Amanda"
      check "Sally"
      click_on "Save Attendance"
    end

    within("table#leader_board tbody") do
      within("tr:nth-child(1)") do
        page.should have_content("Amanda")
        page.should have_content("100%")
      end
      within("tr:nth-child(2)") do
        page.should have_content("Joe")
        page.should have_content("50%")
      end
      within("tr:nth-child(3)") do
        page.should have_content("Sally")
        page.should have_content("50%")
      end
      within("tr:nth-child(4)") do
        page.should have_content("Bob")
        page.should have_content("0%")
      end
      within("tr:nth-child(5)") do
        page.should have_content("Kip")
        page.should have_content("N/A")
      end
    end
  end
end
