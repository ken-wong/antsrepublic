class Api::QueenWorksController < Api::BaseController
#encoding=UTF-8
  def search
    @q = QueenWork.ransack(title_cont: params[:q])
    @queen_works = @q.result
  end

  def following_list
    @queen_works = User.find(params[:user_id]).all_following
  end

  def index
  	if params[:category].nil?
      @queen_works = QueenWork.all
    else
      #@products = QueenWork.where("category = '#{params[:category]}'").page params[:page]
     	
     	#TODO: per page 12
      @q = QueenWork.ransack(category_eq: params[:category])
      @queen_works = @q.result.page params[:page]

    end
  end
end
