class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find_by(id: params[:cat_id])
    @cat_rentals = @cat.cat_rental_requests
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    @errors = []
  end

  def create
    @cats = Cat.all
    @errors = []
    @cat_rental_request = CatRentalRequest.new(cat_rental_params)

    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      @errors = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  private
  def cat_rental_params
    params.require(:cat_rental).permit(:start_date,:end_date,:status,:cat_id)
  end
end
