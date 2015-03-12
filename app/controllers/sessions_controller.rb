class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
      params[:user][:password])
    unless @user.nil?
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Not a valid username/password combination"]
      @user = User.new(email: params[:user][:email])
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:token] = nil
    redirect_to new_session_url
  end
end
