class WelcomeController < ApplicationController
  def index
    @q = QueenWork.ransack(category_eq: params[:category])
    @products = @q.result
    @queens = Queen.all
  end
end