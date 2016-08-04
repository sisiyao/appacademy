class AlbumsController < ApplicationController
  before_action :require_user!

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(@album.band)
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    redirect_to album_url(@album)
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :record_type)
  end
end
