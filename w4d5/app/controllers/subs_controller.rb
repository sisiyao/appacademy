class SubsController < ApplicationController
  before_action :require_user!, except: [:index, :show]
  before_action :require_moderator!, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Can't update this subreddit"]
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def show
    @sub = Sub.find(params[:id])
  end


  private
  def require_moderator!
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      redirect_to sub_url(params[:id])
    end
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

end
