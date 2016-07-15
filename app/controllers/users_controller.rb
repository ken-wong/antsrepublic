class UsersController < ApplicationController
  def dashboard
    @messages = ['欢迎登陆','万达审核中']
    @test = '1'
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to dashboard_user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params.except(:email))
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def choose
  end

  def dashboard
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(
      :email, :name, :cell, :password,
      :password_confirmation, :company, :avatar)
    end
end
