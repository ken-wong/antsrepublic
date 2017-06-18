class ComplainsController < ApplicationController
  def index
    if current_user
      @complains = current_user.complains.all
      @complain = current_user.complains.new
    else
      redirect_to login_path
    end
  end

  def create
    @complain = current_user.complains.new(complain_params)
    if @complain.save
      redirect_to complain_path
    else
      respond_to do |format|
        format.html { redirect_to complain_path, notice: 'error' }
        format.json { render json: @complain.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def complain_params
    params.require(:complain).permit(:title, :content)
  end
end
