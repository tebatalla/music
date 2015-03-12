class TracksController < ApplicationController
  before_action :require_log_in

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.new[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.try(:destroy)
    redirect_to album_url(@track.album)
  end

  def update
    @track = Track.update(params[:id], track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.new[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def new
    @track = Track.new
    render :new
  end

  private
  def track_params
    params.require(:track).permit([:name, :album_id, :lyrics, :bonus])
  end
end
