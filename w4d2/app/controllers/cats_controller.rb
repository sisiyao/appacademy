class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by(id: params[:id])
  end

  def new
    @cat = Cat.new
    @errors = []
  end

  def create
    @cat = Cat.new(cat_params)
    @errors = []
    if @cat.save
      redirect_to cat_url(@cat)
    else
      @errors = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    @errors = []
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      @errors = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:birth_date,:name,:color,:sex,:description)
  end
end
