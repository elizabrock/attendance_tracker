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
end
