class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :joke

  def joke
    if Rails.env.development?
      stub_request(:get, /icndb.com/).
        to_return(status: 200, body: "Chuck Norris is sleeping", headers: {})
    end

    @haar_joke = HaarJoke.create_joke
  end
end
