class UsersController < ApplicationController
  def dashboard

  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     if User.count > 0 then
       @user.add_role 'visitor' 
      else 
        @user.add_role 'admin'
      end
      @user.send_message(User.first, "欢迎注册蚂蚁共和,请在个人<a href='#{user_path(@user)}'>中心申请认证</a> 甲方或蚁后")  
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

  def following_list
    @user = User.find(params[:id])
    @products = @user.all_following
  end

  def voteable_list
    @user = User.find(params[:id])
    @products = @user.find_liked_items
  end

  def project_list
    @user = User.find(params[:id])
    @products = []
    @products = Product.where("user_id = ?", current_user.id) if @user.has_role?(:owner)
    @products = Product.where("queen_id = ?", current_user.id) if @user.has_role?(:queen)
  end

  def dashboard
    @user = User.find(params[:id])
    @messages = @user.messages
  end

  def choose
    @user = User.find(params[:id])
  end



  def verify
    @user = User.find(params[:id])
    session[:role] = params[:role]
    if @user.profile.nil? then
      redirect_to new_user_profile_path(user_id: params[:id])
    else
      redirect_to edit_user_profile_path(user_id: params[:id])
    end
  end

  private
    def user_params
      params.require(:user).permit(
      :email, :name, :cell, :password,
      :password_confirmation, :company, :avatar, :state)
    end
end
