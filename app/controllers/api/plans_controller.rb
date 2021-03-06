class Api::PlansController < Api::BaseController
  def create
    need = Need.find(params[:need_id])
    @plan = need.plans.build(plan_params)
    date = plan_params[:dead_line].to_time
    if (date > Time.now) && @plan.save
      #@plan.need.start!
      render json: {plan_id: @plan.id, plan: @plan}, status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def index
    @plans = Plan.ransack(need_id_eq: params[:need_id]).result
  end

  def update
    @plan = Plan.find(params[:id])

    if @plan.update(plan_params)
      @plan.need.start!
      render json: {plan: @plan}, status: 200
    else
      return api_error(status: 422)
    end
  end

  def destroy
    Plan.find(params[:id]).destroy
    render json: :no_content
  end

  private
    def plan_params
      params.require(:plan).permit(
        :dead_line, :title, :state)
    end
end
