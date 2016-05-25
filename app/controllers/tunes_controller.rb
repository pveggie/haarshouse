class TunesController < ApplicationController
  require 'json'
  require 'open-uri'
  before_action :find_tune, only: [:show, :edit, :update, :destroy]

  def index
    @haar_joke = generate_joke
    @tunes = Tune.all
  end

  def show
  end

  def new
    @tune = Tune.new
  end

  def create
    @tune = Tune.new(tune_params)
  end

  def edit
  end

  def update
    @tune.update(tune_params)
  end

  def destroy
    @tune.delete
  end

  private
  def find_tune
    @tune = Tune.find(params[:id])
  end

  def tune_params
    params.require(:tune).permit(:poster, :url, :poster_comment)
  end

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
