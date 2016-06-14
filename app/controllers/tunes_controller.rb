class TunesController < ApplicationController
  require 'json'
  require 'open-uri'
  before_action :find_tune, only: [:edit, :update, :destroy]

  def index
    @tunes = Tune.all
  end

  def new
    @tune = Tune.new
  end

  def create
    @tune = Tune.new(tune_params)
    if @tune.save
      redirect_to tunes_path
    else
      flash[:alert] = "Song not updated."
      render :new
    end
  end

  def update
    @tune.update(tune_params)
    if @tune.save
      redirect_to tunes_path
    else
      flash[:alert] = "Song not updated."
      render :new
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
    params.require(:tune).permit(:game_title, :song_title, :youtube_video_id)
  end
end
