class Api::QueenWorksController < Api::BaseController
  def search
    @q = QueenWork.ransack(title_cont: params[:q])
    @queen_works = @q.result
  end

  def following_list
    @queen_works = User.find(params[:user_id]).all_following
  end
end