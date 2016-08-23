class Api::AttachmentsController < Api::BaseController
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

  def show
  	@attachment = Attachment.find(params[:id])
  end

  def create
  	if params[:task_id].present?	
    	@attachment = Task.find(params[:task_id]).attachments.build(attachment_params)
    elsif params[:queen_work_id].present?	
    	@attachment = QueenWork.find(params[:queen_work_id]).attachments.build(attachment_params)
    else
    	@attachment = Attachment.build(attachment_params)
    end

    @attachment.file_name = @attachment.file.base_name
    if @attachment.save
      render json: {attachment_id: @attachment.id, attachment: @attachment.to_json}, status: 201
    else
      return api_error(status: 422)
    end  
  end

  def destroy
    Attachment.find(params[:id]).destroy
    render json: :no_content
  end

  private
  def attachment_params
    params.require(:attachment).permit(:attachmentable_id, :attachmentable_type, :file_name, :file)
  end
end