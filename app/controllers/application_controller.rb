class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :joke

  def joke
    @haar_joke = generate_joke
  end

  private
  def generate_joke
  joke = ""
  chuck_norris = false

  until chuck_norris
    joke = get_joke_from_api
    return "Zzzzzzzzzzzzzzz." if joke.nil?

    if joke =~ /chuck norris/i
      #let's get rid of the racist, sexist and nasty ones...
      chuck_norris = true unless joke =~ /race|woman|women|gay|black|natives|porn|handicap|god|bible|staring|rape|condom/i
    end
    haar_joke = joke.gsub(/chuck norrises/i, "Haars")
    haar_joke = joke.gsub(/chuck norris\'s/i, "Haar's")
    haar_joke = joke.gsub(/chuck norris/i, "Haar")
    haar_joke = haar_joke.gsub(/penis|dick/i, "axe")
    haar_joke = haar_joke.gsub(/american|america/i, "Daein")
    haar_joke = haar_joke.gsub(/beat/i, "sleep")
    haar_joke = haar_joke.gsub(/superman/i, "Chuck Norris")
    haar_joke = haar_joke.gsub(/beard/i, "eyepatch")
    haar_joke = haar_joke.gsub(/pick\-up/i, "wyvern")
  end
  return haar_joke
end


def get_joke_from_api
  api_url = 'http://api.icndb.com/jokes/random?escape=javascript'
  joke = ""

  begin
    open(api_url) do |stream|
      joke = JSON.parse(stream.read)
    end
    joke['value']['joke']
  rescue StandardError
    return nil
  end
end
end
