class QueenSessionsController < ApplicationController
  def new
    @queen = Queen.new
  end

  def create
    @queen = Queen.find_by(email: params[:queen_session][:email])
    if @queen && @queen.authenticate(params[:queen_session][:password])
      queen_log_in(@queen)
      redirect_to root_url
    else
      flash.now[:danger] = t(:invalid_email_or_password)
      render 'new'
    end
  end

  def destroy
    queen_logout if queen_logged_in?
    redirect_to root_url
  end
end