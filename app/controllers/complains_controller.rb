class ComplainsController < ApplicationController
  def index
    if current_user
      if current_user.state == "认证通过"
        @complains = current_user.complains.all
        @complain = current_user.complains.new
      else
      end
    else
      render html: 'please login'
    end
  end

  def create
    @complain = current_user.complains.new(complain_params)
    if @complain.save
      redirect_to complain_path
    end
  end

  private
  def complain_params
    params.require(:complain).permit(:title, :content)
  end
end
