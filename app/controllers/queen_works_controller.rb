class QueenWorksController < ApplicationController
	before_action :authenticate_user!, only: [:vote_it, :follow_it]
  before_action :set_tags

  def index
    @q = QueenWork.ransack(params[:q])
    @products = @q.result(distinct: true)

    if params[:user_id]
      @products = @products.where("user_id = #{params[:user_id]}")  
    end

    if params[:category]
      @products = @products.where("category = '#{params[:category]}'")
    end

    @products = Kaminari.paginate_array(@products).page(params[:page]).per(6)

    render '/products/index'
  end

  def show
  	@product = QueenWork.find(params[:id])
  	render '/products/show'
  end

  def new
  	@queen_work = QueenWork.new

  end

  def edit
    @queen_work = QueenWork.find(params[:id])
    @attachments = @queen_work.attachments
    @attachment = @queen_work.attachments.build
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
    @attachments = @queen_work.attachments
    respond_to do |format|
      if @queen_work.save
        @queen_work.final!
        format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully created.' }
        format.json { render :json => [@queen_work].to_json }
      else
        format.html { render :new }
        format.json { render json: @queen_work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @queen_work = QueenWork.find(params[:id])
    @attachments = @queen_work.attachments
    respond_to do |format|
      if @queen_work.update(queen_work_params)

        format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully updated.' }
        format.json { render :json => [@queen_work].to_json }
        # format.json { render :show, status: :ok, location: @queen_work }
      else
        format.html { render :edit }
        format.json { render json: @queen_work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @queen_work = QueenWork.find(params[:id])
    @queen_work.destroy
    respond_to do |format|
      format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
  def queen_work_params
    params.require(:queen_work).permit(:title, :avatar, 
      :client_name, :ref_price, :category, :main_media, 
      :description, :user_id, :start_date, 
      :ending_date, :final_date, :price_range)
  end

  def set_tags
    @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
  end

end
