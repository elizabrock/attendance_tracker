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

    before do
      Fabricate(:attendance, student: bob, date: 3.days.ago, present: true)
      Fabricate(:attendance, student: bob, date: 2.days.ago, present: true)
      Fabricate(:attendance, student: bob, date: 1.days.ago, present: true)
      Fabricate(:attendance, student: sally, date: 3.days.ago, present: true)
      Fabricate(:attendance, student: sally, date: 2.days.ago, present: true)
      Fabricate(:attendance, student: sally, date: 1.days.ago, present: true)
      Fabricate(:attendance, student: joe, date: 3.days.ago, present: false)
      Fabricate(:attendance, student: joe, date: 2.days.ago, present: true)
      Fabricate(:attendance, student: joe, date: 1.days.ago, present: false)
      Fabricate(:attendance, student: amanda, date: 3.days.ago, present: true)
      Fabricate(:attendance, student: amanda, date: 2.days.ago, present: true)
      Fabricate(:attendance, student: amanda, date: 1.days.ago, present: false)
      Fabricate(:attendance, student: martha, date: 1.days.ago, present: true)
      scott
    end
    it "returns the students sorted by attendance percent, then name" do
      Student.all_by_attendance.should == [ bob, martha, sally, amanda, joe, scott ]
    end
  end
end
