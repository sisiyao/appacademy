class SessionsController < ApplicationController

  before_action :require_no_user!, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user
      login(user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  # def session_params
  #   params.require(:session).permit()
  # end
end
