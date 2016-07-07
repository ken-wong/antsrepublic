class QueensController < ApplicationController
  
  def dashboard

  end

  def new
    @queen = Queen.new
  end

  def create
    @queen = Queen.new(queen_params)
    if @queen.save
      queen_log_in(@queen)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @queen = Queen.find(params[:id])
  end

  def update
    @queen = Queen.find(params[:id])
    if @queen.update(queen_params.except(:email))
      redirect_to @queen
    else
      render 'edit'
    end
  end

  def show
    @queen = Queen.find(params[:id])
  end

  def choose
  end

  private
    def queen_params
      params.require(:queen).permit(
      :email, :name, :cell, :password,
      :password_confirmation, :company, :avatar, :desc)
    end
end
