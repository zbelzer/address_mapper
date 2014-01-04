class Location < ActiveRecord::Base
  validates :address, :presence => true, :uniqueness => true

  # Override the default setter to capitalize incoming addresses.
  #
  # @param [String] value
  def address=(value)
    super value && value.titleize
  end
end
