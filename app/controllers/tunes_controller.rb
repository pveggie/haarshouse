# Actions for adding, removing and editing youtube songs.
class TunesController < ApplicationController
  require 'json'
  require 'open-uri'
  before_action :find_tune, only: [:show, :edit, :update, :destroy]

  def index
    @tunes = params[:sort].nil? ? Tune.by_date : tunes_sorted(params[:sort])
  end

  def search
    @tunes = Tune.search(params[:q])
    @hits = @tunes.count
  end

  def new
    @tune = Tune.new
  end

  def show
    @tune.views += 1
    @tune.save
    respond_to do |format|
      format.html do
        flash[:alert] = "JavaScript needs to be enabled to play videos."
        redirect_to tunes_path
      end
      format.js
    end
  end

  def create
    if user_signed_in?
      @tune = current_user.tunes.build(tune_params)
    else
      @tune = Tune.new(tune_params)
    end
    
    if @tune.save
      redirect_to tunes_path
    else
      flash[:alert] = "Song not created."
      render :new
    end
  end

  def update
    @tune.update(tune_params)
    if @tune.save
      redirect_to tunes_path
    else
      flash[:alert] = "Song not updated."
      render :edit
    end
  end

  def destroy
    @tune.delete
    redirect_to tunes_path
  end

  private

  def find_tune
    @tune = Tune.find(params[:id])
  end

  def tune_params
    params.require(:tune).permit(:game_title, :song_title, :youtube_video_id, :user_id)
  end

  def tunes_sorted(sort)
    sort.downcase!
    Tune.send(sort.to_sym)
  end
end
