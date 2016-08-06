class SessionsController < ApplicationController

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_credentials(email, password)
    if user
      login_user!(user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["cannot find user!"]
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end


end
