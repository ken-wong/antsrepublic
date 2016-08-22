class QueenWorksController < ApplicationController
  def show
  	@product = QueenWork.find(params[:id])
  	render '/products/show'
  end

  def new
  	@queen_work = QueenWork.new
  end

  def edit
    @queen_work = QueenWork.find(params[:id])
  end

  def follow_it

  	queen_work = QueenWork.find(params[:id])
  	current_user.following?(queen_work) ? current_user.stop_following(queen_work) : current_user.follow(queen_work)
  	
  	redirect_to queen_work_path(params[:id])
  end

  def vote_it
  	queen_work = QueenWork.find(params[:id])
  	queen_work.liked_by current_user
  	redirect_to queen_work_path(params[:id])
  end

  def create
    @queen_work = QueenWork.new(queen_work_params)
    @queen_work.queen_id = current_user.id

    respond_to do |format|
      if @queen_work.save
        @queen_work.final!
        format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully created.' }
        format.json { render :json => [@queen_work.to_jq_upload].to_json }
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
        format.json { render :json => [@queen_work.to_jq_upload].to_json }
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
