class SessionsController < ApplicationController
  def new
    #login form
    render :new
  end

  def create
    #login
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user
      log_in_user!(@user)
      redirect_to bands_url
    else
      flash.now[:errors] = ["Wrong password/email"]
      render :new
    end
  end

  def destroy
    #logout
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
