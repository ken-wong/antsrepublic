class Api::TasksController < Api::BaseController
  def create
    need = Need.find(params[:need_id])
    task = need.tasks.build(task_params)
    if task.save
      render json: {task_id: task.id}, status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.ransack(need_id_eq: params[:need_id]).result
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render 'show'
    else
      return api_error(status: 422)
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    render json: :no_content
  end

  private
    def task_params
      params.require(:task).permit(
        :dead_line, :title, :description)
    end
end