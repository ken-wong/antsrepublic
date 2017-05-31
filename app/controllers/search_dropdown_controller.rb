class SearchDropdownController < ApplicationController
  def index
    respond_to do |f|
      f.js { render :index, locals: { search: params[:search] } }
    end
  end
end
