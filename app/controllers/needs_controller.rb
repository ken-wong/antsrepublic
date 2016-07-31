class NeedsController < ApplicationController
  def new
    @need = Need.new
    @need.user_id = params[:user_id]
    @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
  end

  def index
  end

  def edit
    @need = Need.find(params[:id])
    @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
  end

  def show
    @need = Need.find(params[:id])
  end

  def update
    @need = Need.find(params[:id])
    respond_to do |format|
      if @need.update(need_params)
        format.html { redirect_to project_list_user_path(current_user), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @need }
      else
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @need = Need.new(need_params)
    @need.user_id = current_user.id
    @need.state = '等待审核'

    respond_to do |format|
      if @need.save
        format.html { redirect_to project_list_user_path(current_user), notice: 'Product was successfully updated.'  }
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
        :description, :user_id, :start_date, 
        :ending_date, :final_date, :price_range)
    end
end
