class GoalsController < ApplicationController
before_action :require_signed_in
  def create
      @goal = Goal.new(goal_params)
      @goal.user_id = current_user.id
      if @goal.save
         redirect_to goals_url
      else
        flash.now[:errors] = @goal.errors.full_messages
        render :new
      end
  end

  def new
    @goal = Goal.new
  end

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find_by(params[:id])
  end

  def edit
    @goal = Goal.find_by(params[:id])
  end

  def update
    @goal = Goal.find_by(params[:id])
    if @goal.update(goal_params)
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  def goal_params
    params.require(:goal).permit(:content,:public_status,:completed)
  end
end
