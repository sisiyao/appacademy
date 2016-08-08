class UsersController < ApplicationController
  before_action :require_user!, only: :show

  def new
    if !current_user
      render :new
    else
      redirect_to subs_url
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if params[:id].to_i == current_user.id
      render :show
    else
      redirect_to user_url(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
