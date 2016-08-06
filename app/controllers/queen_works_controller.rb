class QueenWorksController < ApplicationController
  def show
  	redirect_to product_path(params[:id])
  end

  def new
  	@queen_work = QueenWork.new
  end

  def edit
    @queen_work = QueenWork.find(params[:id])
  end

  def create
    @queen_work = QueenWork.new(queen_work_params)
    @queen_work.queen_id = current_user.id

    respond_to do |format|
      if @queen_work.save
        @queen_work.final!
        format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @queen_work }
      else
        format.html { render :new }
        format.json { render json: @queen_work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
      @queen_work = Product.find(params[:id])
    respond_to do |format|
      if @queen_work.update(queen_work_params)

        format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @queen_work }
      else
        format.html { render :edit }
        format.json { render json: @queen_work.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def queen_work_params
    params.require(:queen_work).permit(:title, :avatar, 
      :client_name, :ref_price, :category, :main_media, 
      :description, :user_id, :start_date, 
      :ending_date, :final_date, :price_range)
  end
end
