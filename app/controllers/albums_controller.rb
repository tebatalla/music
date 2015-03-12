class AlbumsController < ApplicationController
  before_action :require_log_in

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.new[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.try(:destroy)
    redirect_to albums_url
  end

  def update
    @album = Album.update(params[:id], album_params)
    if @album.save
      redirect_to band_url(@album)
    else
      flash.new[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def new
    @album = Album.new
    render :new
  end

  private
  def album_params
    params.require(:album).permit([:name, :band_id, :studio])
  end
end
