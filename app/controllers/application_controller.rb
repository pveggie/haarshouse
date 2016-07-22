class ApplicationController < ActionController::Base
  require 'json'
  require 'open-uri'
  # require 'haar_joke'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :joke

  def joke
    @haar_joke = HaarJoke.create_joke
  end
end
