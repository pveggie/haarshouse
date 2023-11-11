class ApplicationController < ActionController::Base
  before_action :joke

  def joke
    if Rails.env.development?
      stub_request(:get, /icndb.com/).
        to_return(status: 200, body: "Chuck Norris is sleeping", headers: {})
    end

    @haar_joke = HaarJoke.create_joke
  end
end
