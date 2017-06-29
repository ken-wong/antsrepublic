class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_tags

  # GET /products
  # GET /products.json
  def index
    
    if params[:user_id].nil?
      @products = Product.page params[:page]
    else
      @products = Product.where("user_id = #{params[:user_id]}")  
    end
    
    if params[:category].nil?
      @products = QueenWork.page params[:page]
    else
      @products = QueenWork.where("category = '#{params[:category]}'")
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    category = @product.category
    @voter = @product.votes_for.limit(4).map do |v|
      v.voter
    end
    @similar = Product.where(category: category).limit(4)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]

    respond_to do |format|
      if @product.save
        @product.final!
        format.html { redirect_to project_list_user_path(current_user), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
      @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)

        format.html { redirect_to project_list_user_path(current_user), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to product_list_user_path(current_user), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_tags
      @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :avatar, 
        :client_name, :ref_price, :category, :main_media, 
        :description, :user_id, :start_date, 
        :ending_date, :final_date, :price_range)
    end
end
