class QueensController < ApplicationController
  
  def dashboard
    @queen = Queen.find(params[:id])
    @messages = ['url1','url2']
  end

  def index
    @queens = Queen.with_role(:queen)
  end

  def new
    @queen = Queen.new
  end

  def create
    @queen = Queen.new(queen_params)
    if @queen.save
      queen_log_in(@queen)
      redirect_to dashboard_queen_path(@queen)
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
    @queen = User.find(params[:id])
    @queens = Queen.with_role(:queen)
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
