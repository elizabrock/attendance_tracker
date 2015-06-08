require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many :attendances }
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
  describe "fabricating a model" do
    it "should succeed" do
      Fabricate(:student)
    end
  end
  describe ".all_by_attendance" do
    let(:bob){ Fabricate(:student, name: "Bob") }
    let(:sally){ Fabricate(:student, name: "Sally") }
    let(:joe){ Fabricate(:student, name: "Joe") }
    let(:amanda){ Fabricate(:student, name: "Amanda") }
    let(:martha){ Fabricate(:student, name: "Martha") }
    let(:scott){ Fabricate(:student, name: "Scott") }

    let(:three){ Fabricate(:school_day, date: 3.days.ago) }
    let(:two){ Fabricate(:school_day, date: 2.days.ago) }
    let(:one){ Fabricate(:school_day, date: 1.days.ago) }

    before do
      Fabricate(:attendance, student: bob, school_day: three, present: true)
      Fabricate(:attendance, student: bob, school_day: two, present: true)
      Fabricate(:attendance, student: bob, school_day: one, present: true)
      Fabricate(:attendance, student: sally, school_day: three, present: true)
      Fabricate(:attendance, student: sally, school_day: two, present: true)
      Fabricate(:attendance, student: sally, school_day: one, present: true)
      Fabricate(:attendance, student: joe, school_day: three, present: false)
      Fabricate(:attendance, student: joe, school_day: two, present: true)
      Fabricate(:attendance, student: joe, school_day: one, present: false)
      Fabricate(:attendance, student: amanda, school_day: three, present: true)
      Fabricate(:attendance, student: amanda, school_day: two, present: true)
      Fabricate(:attendance, student: amanda, school_day: one, present: false)
      Fabricate(:attendance, student: martha, school_day: one, present: true)
      scott
    end
    it "returns the students sorted by attendance percent, then name" do
      Student.all_by_attendance.should == [ bob, martha, sally, amanda, joe, scott ]
    end
  end
end
