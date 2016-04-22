class TunesController < ApplicationController
  before_action :find_tune only: [:edit, :update, :destroy]

  def index
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

end
