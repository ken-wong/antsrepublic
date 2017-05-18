class NeedImgsController < ApplicationController
  def destroy
    @need = Need.find(params[:need_id])
    img = @need.need_imgs.find(params[:id])
    img.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render action: :create }
    end
  end

  def create
    @need = Need.find(params[:need_id])
    @image = @need.need_imgs.build(need_img_params)
    @image.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render action: :create }
    end
  end

  private
  def need_img_params
    params.require(:need_image).permit(:photo)
  end
end
