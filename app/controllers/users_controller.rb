class UsersController < ApplicationController
  def dashboard
    @messages = User.find(current_user).messages.where(created_at: ((Time.now - 1.month)..(Time.now))).page(params[:page]).per(8)
    if(request.url.split('?')[1]!=nil)
      @@page = request.url.split('?')[1].split('=')[1]
    else
      @@page = 1
    end
  end

  def mread

    m = User.find(current_user).messages.where("messages.id = #{params[:mid]}").first
    m.mark_as_read
    redirect_to dashboard_user_path(page: params[:page])
  end

  def new
    @user = User.new
  end

  def bind_wx
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
      @user.send_message(@user, "欢迎注册蚂蚁共和,请在<a href='#{user_url(@user)}'>个人资料</a> 申请认证甲方或蚁后")
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
    @user.attributes = user_params.except(:email)
    if @user.save(validate: false)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def following_list
    @products = current_user.all_following
  end

  def voteable_list
    @products = current_user.find_voted_items
  end

  def project_list
    if current_user.has_role?(:owner)
      @products = Need.where("user_id = ? and state <> '我的案例'", current_user.id).order(created_at: :desc)
    elsif current_user.has_role?(:queen)
      @products = Need.where("queen_id = ? and state <> '我的案例'", current_user.id).order(created_at: :desc)
    else
      @products = []
    end
  end

  def product_list
    @products = []
    @products = Queen.find(current_user).queen_works.order(created_at: :desc)
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
      :password_confirmation, :company, :avatar, :state, :description, :wx_openid)
    end
end
