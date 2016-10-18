class Api::NeedsController < Api::BaseController
  def vote_to_me
    @need     = Need.find(params[:id])
    voter_id  = params[:voter_id]
    vote_type = params[:vote_type]
    stars     = params[:stars]

    @need.vote_by voter: User.find(voter_id), vote_scope: "#{vote_type}", vote_weight: stars

    vspeed   = @need.find_votes_for(:vote_scope => 'speed').sum(:vote_weight) # => 6
    vquality = @need.find_votes_for(:vote_scope => 'quality').sum(:vote_weight) # => 6
    vservice = @need.find_votes_for(:vote_scope => 'service').sum(:vote_weight) # => 6
    render json: {vote_speed: vspeed, vote_quality: vquality, vote_service: vservice}, status: 201
  end

  def vote_sum
    @need     = Need.find(params[:id])
    vspeed   = @need.find_votes_for(:vote_scope => 'speed').sum(:vote_weight) # => 6
    vquality = @need.find_votes_for(:vote_scope => 'quality').sum(:vote_weight) # => 6
    vservice = @need.find_votes_for(:vote_scope => 'service').sum(:vote_weight) # => 6
    render json: {vote_speed: vspeed, vote_quality: vquality, vote_service: vservice}, status: 201
  end
end