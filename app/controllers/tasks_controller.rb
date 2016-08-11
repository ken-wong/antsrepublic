class TasksController < InheritedResources::Base

  def index
    @need = Need.find(params[:need_id])
    @tasks = @need.tasks
    @plans = @need.plans
  end

  def new
  	@need = Need.find(params[:need_id])
  	@task = @need.tasks.build
  end

  def show
  	@need = Need.find(params[:need_id])
  	@task = Task.find(params[:id])
  end


  def destroy
  	@need = Need.find(params[:need_id])
  	@task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to need_tasks_path(need_id: params[:need_id]), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
    @task = Task.new(task_params)
    @need = @task.need
    respond_to do |format|
      if @task.save
        format.html { redirect_to need_tasks_path(need_id: @task.plan.need_id), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def task_params
 			params.require(:task).permit(:title, :description, :plan_id, :attachment, :need_id)
    end
end

