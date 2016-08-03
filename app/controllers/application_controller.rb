class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  

  protected
# todo, replace devise with ken's code
  def authenticate_user!
    if current_user.blank?
    	redirect_to login_path
    end
  end
end
