class Api::QueensController < Api::BaseController
  def search
    @q = Queen.ransack(name_cont: params[:q])
    @queens = @q.result
  end

  def index
  	@queens = Queen.page params[:page]
  end
end