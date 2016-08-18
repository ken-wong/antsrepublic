class Api::AttachmentsController < Api::BaseController
  def index
    @task = Task.find(params[:task_id])
    @attachments = @task.attachments

    render json: {attachments: @attachments}, status: 201
  end

  def show
  	@attachment = Attachment.find(params[:id])
  end

  def create
    @attachment = Attachment.new(attachement_params)
    @attachment.file_name = @attachment.file.base_name
    if @attachment.save
      render json: {attachment_id: @attachment.id, attachment: @attachment.file_name}, status: 201
    else
      return api_error(status: 422)
    end  
  end

  def destroy
    Attachment.find(params[:id]).destroy
    render json: :no_content
  end

  private
  def attachement_params
    params.require(:attachment).permit(:task_id, :file_name, :file)
  end
end