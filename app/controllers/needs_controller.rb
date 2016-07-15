class NeedsController < ApplicationController
  def new
    @need = Need.new
    @need.user_id = params[:user_id]
  end

  def index
  end

  def edit
    @need = Need.find(params[:id])
  end

  def show
    @need = Need.find(params[:id])
  end

  def update
  end

  def create
    @need = Need.new(need_params)
    @need.state = '等待审核'

    respond_to do |format|
      if @need.save
        format.html { redirect_to @need, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @need }
      else
        format.html { render :new }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  def desttroy
  end

  def need_params
    params.require(:need).permit(:title, :avatar, 
        :client_name, :ref_price, :category, :main_media, 
        :description, :queen_id, :user_id, :start_date, :ending_date, :final_date, :price_range)
  end
end
