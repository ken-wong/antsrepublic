class WelcomeController < ApplicationController
  def index
    @q = Product.ransack(category_eq: params[:category])
    @products = @q.result
    @queens = User.with_role(:queen)
  end
end