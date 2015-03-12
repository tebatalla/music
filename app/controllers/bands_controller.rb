class BandsController < ApplicationController
  before_action :require_log_in

  def index
    @bands = Band.all
    render :index
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.new[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.try(:destroy)
    redirect_to bands_url
  end

  def update
    @band = Band.update(params[:id], band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.new[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def new
    @band = Band.new
    render :new
  end

  private
  def band_params
    params.require(:band).permit([:name])
  end
end
