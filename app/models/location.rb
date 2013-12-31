class Location < ActiveRecord::Base
  validates :address, :presence => true
end
