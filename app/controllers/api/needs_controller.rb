class Api::NeedsController < Api::BaseController
  def vote_to_me
    @need     = Need.find(params[:id])
    voter_id  = params[:voter_id]
    speedStars     = params[:speedStars]
    qualityStars     = params[:qualityStars]
    serviceStars     = params[:serviceStars]

    @need.vote_by voter: User.find(voter_id), vote_scope: "speed", vote_weight: speedStars
    @need.vote_by voter: User.find(voter_id), vote_scope: "quality", vote_weight: qualityStars
    @need.vote_by voter: User.find(voter_id), vote_scope: "service", vote_weight: serviceStars

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

    sp_size =@need.find_votes_for(:vote_scope => 'speed').size
    ql_size =@need.find_votes_for(:vote_scope => 'quality').size
    sv_size =@need.find_votes_for(:vote_scope => 'service').size
    render json: {
        vote_speed: vspeed, 
        vote_quality: vquality, 
        vote_service: vservice, 
        speed_size: sp_size, 
        quality_size: ql_size, 
        service_size: sv_size
        }, status: 201
  end
end
