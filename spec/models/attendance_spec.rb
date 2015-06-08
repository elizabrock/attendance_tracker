require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "validations" do
    it { should belong_to :student }
    it { should validate_presence_of :student }
    it { should validate_presence_of :date }
  end
  describe "fabricating a model" do
    it "should succeed" do
      Fabricate(:attendance)
    end
  end
  describe "percent_present scope" do
    let(:student) { Fabricate(:student) }
    context "always present, across n days" do
      before do
        Fabricate(:attendance, student: student, date: 3.days.ago, present: true)
        Fabricate(:attendance, student: student, date: 2.days.ago, present: true)
        Fabricate(:attendance, student: student, date: 1.days.ago, present: true)
      end
      it { student.attendances.percent_present.should == 100 }
    end

    context "sometimes present, across n days" do
      before do
        Fabricate(:attendance, student: student, date: 3.days.ago, present: false)
        Fabricate(:attendance, student: student, date: 2.days.ago, present: true)
        Fabricate(:attendance, student: student, date: 1.days.ago, present: false)
      end
      it { student.attendances.percent_present.should == 33 }
    end

    context "often present, across n days" do
      before do
        Fabricate(:attendance, student: student, date: 3.days.ago, present: true)
        Fabricate(:attendance, student: student, date: 2.days.ago, present: true)
        Fabricate(:attendance, student: student, date: 1.days.ago, present: false)
      end
      it { student.attendances.percent_present.should == 66 }
    end

    context "present on first day" do
      before do
        Fabricate(:attendance, student: student, date: 1.days.ago, present: true)
      end
      it { student.attendances.percent_present.should == 100 }
    end

    context "brand new" do
      it { student.attendances.percent_present.should == 0 }
    end
  end
end
