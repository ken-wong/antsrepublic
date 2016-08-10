class TasksController < InheritedResources::Base

  def index
    @need = Need.find(params[:need_id])
    @tasks = @need.tasks
  end

  private

    def task_params
      params.require(:task).permit(:dead_line, :title, :description, :state)
    end
end

