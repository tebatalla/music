class UsersController < ApplicationController
  before_action :require_log_in, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(email: params[:user][:email])
    @user.password = params[:user][:password]
    if @user.save
      log_in_user!(@user)
      redirect_to bands_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end
end
