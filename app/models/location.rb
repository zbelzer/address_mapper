class Location < ActiveRecord::Base
  validates :address, :presence => true, :uniqueness => true
end
