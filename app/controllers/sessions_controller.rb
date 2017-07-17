class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if !@user.blank? && @user.authenticate(params[:session][:password])
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

  def wechat
    redirect_to("https://open.weixin.qq.com/connect/qrconnect?appid=#{ENV['WECHAT_APP_ID']}&redirect_uri=http://ebb17fc8.ngrok.io/auth/wechat/callback&response_type=code&scope=snsapi_login&state=web#wechat_redirect
                ")
  end

  def auth_callback
    $client = WeixinAuthorize::Client.new(ENV["WECHAT_APP_ID"], ENV["WECHAT_APP_SECRET"])
    res = $client.get_oauth_access_token(params[:code])
    user_info = $client.get_oauth_userinfo(res.result[:openid], res.result[:access_token]).result
    @user = User.find_by(wx_openid: user_info[:openid])
    if !@user.blank?
      log_in(@user)
      redirect_to dashboard_user_path(@user)
    else
      redirect_to bind_wx_path(user_info)
    end
  end
end
