class TasksController < InheritedResources::Base

  private

    def task_params
      params.require(:task).permit(:dead_line, :title, :description, :state)
    end
end

