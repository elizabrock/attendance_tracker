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
end
