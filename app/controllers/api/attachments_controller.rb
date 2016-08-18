class Api::AttachmentsController < Api::BaseController
  def index
    @task = Task.find(params[:task_id])
    @attachments = @task.attachments

    render json: {attachments: @attachments}, status: 201
  end

  def show
  	@attachment = Attachment.find(params[:id])
  	render json: {attachment: @attachment}, status: 201
  end

  def create
    @attachment = Attachment.new(attachement_params)
    if @attachment.save
      render json: {attachment: @attachment}, status: 201
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
    params.require(:attachment).permit(:task_id, :name, :file)
  end
end