require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "validations" do
    it { should belong_to :student }
    it { should belong_to :school_day }
    it { should validate_presence_of :student }
    it { should validate_presence_of :school_day }
  end
  describe "fabricating a model" do
    it "should succeed" do
      Fabricate(:attendance)
    end
  end
  describe "percent_present scope" do
    let(:three){ Fabricate(:school_day, date: 3.days.ago) }
    let(:two){ Fabricate(:school_day, date: 2.days.ago) }
    let(:one){ Fabricate(:school_day, date: 1.days.ago) }
    let(:student) { Fabricate(:student) }
    context "always present, across n days" do
      before do
        Fabricate(:attendance, student: student, school_day: three, present: true)
        Fabricate(:attendance, student: student, school_day: two, present: true)
        Fabricate(:attendance, student: student, school_day: one, present: true)
      end
      it { student.attendances.percent_present.should == 100 }
    end

    context "sometimes present, across n days" do
      before do
        Fabricate(:attendance, student: student, school_day: three, present: false)
        Fabricate(:attendance, student: student, school_day: two, present: true)
        Fabricate(:attendance, student: student, school_day: one, present: false)
      end
      it { student.attendances.percent_present.should == 33 }
    end

    context "often present, across n days" do
      before do
        Fabricate(:attendance, student: student, school_day: three, present: true)
        Fabricate(:attendance, student: student, school_day: two, present: true)
        Fabricate(:attendance, student: student, school_day: one, present: false)
      end
      it { student.attendances.percent_present.should == 66 }
    end

    context "present on first day" do
      before do
        Fabricate(:attendance, student: student, school_day: one, present: true)
      end
      it { student.attendances.percent_present.should == 100 }
    end

    context "absent on first day" do
      before do
        Fabricate(:attendance, student: student, school_day: one, present: false)
      end
      it { student.attendances.percent_present.should == 0 }
    end

    context "brand new" do
      it { student.attendances.percent_present.should == 0 }
    end
  end
end
