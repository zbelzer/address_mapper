require 'spec_helper'

describe Location do
  let(:valid_attributes) { {:address => "500 Davis St"} }

  context "validations" do
    it "creates a valid Location" do
      location = Location.create(valid_attributes)
      location.should be_persisted
    end
    it "validates presence of address" do
      location = Location.new(:address => nil)
      location.should_not be_valid
      location.errors[:address].should have(1).error
    end

    it "validates uniqueness of address" do
      Location.create(valid_attributes)

      location = Location.new(valid_attributes)
      location.should_not be_valid
      location.errors[:address].should have(1).error
    end
  end 
end
