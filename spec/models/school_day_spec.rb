require 'rails_helper'

RSpec.describe SchoolDay, type: :model do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_uniqueness_of :date }
  end
  describe "fabricating a model" do
    it "should succeed" do
      Fabricate(:school_day)
    end
  end
end
