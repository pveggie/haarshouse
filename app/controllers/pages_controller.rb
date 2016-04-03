class PagesController < ApplicationController
  require 'json'
  require 'open-uri'

  def home
    joke = ""
    chuck_norris = false

    until chuck_norris
      joke = get_joke
      if joke =~ /chuck norris/i
        chuck_norris = true
      end
      @haar_joke = joke.gsub(/chuck norris/i, "Haar")
    end

  end


  private
  def get_joke
    api_url = 'http://api.icndb.com/jokes/random?escape=javascript'
    joke = ""

    open(api_url) do |stream|
      joke = JSON.parse(stream.read)
    end
    joke['value']['joke']
  end
end
