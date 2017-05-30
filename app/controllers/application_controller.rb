class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_global_search
  protect_from_forgery with: :exception
  include ApplicationHelper

  def set_global_search
    @q = Queen.ransack(name_cont: params[:q])
    @qw = QueenWork.ransack(title_cont: params[:q])
  end

  protected
# todo, replace devise with ken's code
  def authenticate_user!
    if current_user.blank?
    	redirect_to login_path
    end
  end
end
