class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_api_keys

  def set_api_keys
    @google_api_key = ENV["GOOGLE_MAPS_API_KEY"]
  end
end
