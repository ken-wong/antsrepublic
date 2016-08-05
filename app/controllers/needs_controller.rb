class NeedsController < ApplicationController
  before_action :authenticate_user!
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
     tags = params[:tags]
     tags = [] if tags.nil?
      
    respond_to do |format|
      @need.tag_list.each do |tag|
        @need.tag_list.remove(tag)
      end
      
      tags.each do |tag|
        @need.tag_list.add(tag)
      end
      @need.save
      @need.redo!

      if @need.update(need_params)
        format.html { redirect_to need_path(@need), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @need }
      else
        @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @need = Need.new(need_params)
    @need.user_id = current_user.id
    tags = params[:tags]
    tags = [] if tags.nil?

    respond_to do |format|
      if @need.save
        tags.each do |tag|
          @need.tag_list.add(tag)
        end
        @need.save
        format.html { redirect_to need_path(@need), notice: 'Product was successfully updated.'  }
        format.json { render :show, status: :created, location: @need }
      else
        @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
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
