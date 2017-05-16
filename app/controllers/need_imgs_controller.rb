class NeedImgsController < ApplicationController
  def destroy
    need = Need.find(params[:need_id])
    img = need.need_imgs.find(params[:id])
    img.destroy
    redirect_to :back
  end

  def create
    need = Need.find(params[:id])
    @image = need.need_imgs
  end
end
