class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to dashboard_user_path(@user)
    else
      flash.now[:danger] = t(:invalid_email_or_password)
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end