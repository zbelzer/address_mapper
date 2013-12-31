require 'spec_helper'

describe Location do
  context "validations" do
    it "validates presence of address" do
      location = Location.new(:address => nil)
      location.should_not be_valid
      location.errors[:address].should have(1).error
    end
  end 
end
