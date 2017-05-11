class PlansController < ApplicationController
	before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def new
  	@need = Need.find(params[:need_id])
  	@plan = Plan.new
  	@plan.need_id = params[:need_id]

  end

  def create
    @plan = Plan.new(plan_params)
    @need = @plan.need
    respond_to do |format|
      if @plan.save
      	@need.start!
        format.html { redirect_to need_tasks_path(need_id: @plan.need_id), notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @plan.destroy
    need_id = @plan.need.id
    respond_to do |format|
      format.html { redirect_to need_tasks_path(need_id: params[:need_id] || need_id), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end
    def plan_params
      params.require(:plan).permit(:title, :need_id, :dead_line, :state)
    end
end
