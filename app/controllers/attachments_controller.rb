
class AttachmentsController < ApplicationController
  def index
  	if params[:task_id].present?	
    	@task = Task.find(params[:task_id])
    	@attachments = @task.attachments
    elsif params[:queen_work_id].present?	
    	@queen_work = QueenWork.find(params[:queen_work_id])
    	@attachments = @queen_work.attachments
    else
    	@attachments = Attachment.all.limit(100)
    end
  end

  def new
  	@task = Task.find(params[:task_id])
  	@attachment = @task.attachments.new
  end

  def show
  	@attachment = Attachment.find(params[:id])
  end

  def create
  	if params[:task_id].present?	
    	@attachment = Task.find(params[:task_id]).attachments.new(attachement_params)
    elsif params[:queen_work_id].present?	
    	@attachment = QueenWork.find(params[:queen_work_id]).attachments.new(attachement_params)
    else
    	@attachment = Attachment.new(attachement_params)
    end

    @attachment.file_name = @attachment.file.base_name
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to need_tasks_path(need_id: Task.find(params[:task_id]).need.id), notice: 'attachment was successfully created.' }
      else
        format.html { render :new }
       
      end
    end
  end

  def destroy
    Attachment.find(params[:id]).destroy
    respond_to do |format|
    	format.html { redirect_to need_tasks_path(need_id: Task.find(params[:task_id]).need.id), notice: 'attachment was deleted.' }
  	end
  end

  private
  def attachement_params
    params.require(:attachment).permit(:attachmentable_id, :attachmentable_type, :file_name, :file)
  end
end
