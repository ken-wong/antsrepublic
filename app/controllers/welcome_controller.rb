class WelcomeController < ApplicationController
  def index
    @q = Product.ransack(category_eq: params[:category])
    @products = @q.result
  end
end