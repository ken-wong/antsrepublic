class WelcomeController < ApplicationController
  def index
    @q = QueenWork.ransack(category_eq: params[:category])
    @products = @q.result
    if Queen.where('sort_no > 0').count > 0
    	@queens = Queen.where('sort_no > 0').order(:sort_no => :desc)
    else
    	@queens = Queen.order(:sort_no => :desc).limit(6)
    end
  end
end