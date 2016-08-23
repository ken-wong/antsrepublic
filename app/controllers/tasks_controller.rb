class TasksController < InheritedResources::Base

  def index
    @need = Need.find(params[:need_id])
    @tasks = @need.tasks.order(created_at: :desc)
    @plans = @need.plans
  end

  def new
  	@need = Need.find(params[:need_id])
  	@task = @need.tasks.build
  end

  def show
  	@need = Need.find(params[:need_id]) if params[:need_id]
  	@task = Task.find(params[:id])
  end

  def edit
  	@task = Task.find(params[:id])
  	@need = @task.need
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
      	message_str = "蚁后提交了<a href='#{need_path(@need)}'>#{@need.title}</a> 的工作成果: #{@task.title}" 
    		current_user.send_message(@need.user, message_str)
    
        format.html { redirect_to need_tasks_path(need_id: @task.plan.need_id), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
      @task = Task.find(params[:id])
      @need = @task.need
    respond_to do |format|
      if @task.update(task_params)
      	@task.redo!

        format.html { redirect_to need_tasks_path(@task.need), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  def confirm
    @task = Task.find(params[:id])
    @task.confirm!
    respond_to do |format|
      format.html { redirect_to need_tasks_path(@task.need_id), notice: 'Task was successfully updated.' }
    end
  end

  def refuse
    @task = Task.find(params[:id])
    @task.refuse!
    respond_to do |format|
      format.html { redirect_to need_tasks_path(@task.need_id), notice: 'Task was successfully updated.' }
    end
  end

  private

    def task_params
 			params.require(:task).permit(:title, :description, :plan_id, :need_id, :state)
    end
end

