class TracksController < ApplicationController
  before_action :require_user!

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album)
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update(track_params)
    redirect_to track_url(@track)
  end

  def show
    @track = Track.find(params[:id])
    @notes = @track.notes
    render :show
  end

  private
  def track_params
    params.require(:track).permit(:album_id, :title, :track_type, :lyrics)
  end
end
