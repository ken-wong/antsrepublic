class QueenWorksController < ApplicationController
  def show
  	redirect_to product_path(params[:id])
  end

end
