class Api::V1::VotesController < Api::V1::ApiController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def destroy
    binding.pry
    if Vote.find_by(user_id: current_user.id, review_id: params["/votes?review_id"])
      Vote.find_by(user_id: current_user.id, review_id: params["/votes?review_id"]).destroy
    end

    review = Review.find(params["/votes?review_id"])

    render json: {
      up_votes: Vote.where(review_id: params[:review_id], up_vote: true).count,
      down_votes: Vote.where(review_id: params[:review_id], up_vote: false).count,
      review: review
      }
  end

  def create
    #if user already voted on this review, set previous vote as vote variable
    if Vote.find_by(user_id: current_user.id, review_id: params[:review_id].to_i)
      vote = Vote.find_by(user_id: current_user.id, review_id: params[:review_id].to_i)
      #if user's new vote does not match their previous vote
      if params[:up_vote] != vote.up_vote.to_s
      # change vote's up_vote attribute to match most recent vote
        vote.toggle!(:up_vote)
      end
    #elsif user has not previously voted on this review, and they down voted, create vote with down vote attribute
    elsif params[:up_vote] == "false"
      vote = Vote.new(review_id: params[:review_id].to_i,
      user_id: current_user.id, up_vote: false)
    else #create vote with up vote attribute
      vote = Vote.new(review_id: params[:review_id].to_i,
      user_id: current_user.id)
    end

    vote.save

    render json: {
      up_votes: Vote.where(review_id: params[:review_id], up_vote: true).count,
      down_votes: Vote.where(review_id: params[:review_id], up_vote: false).count,
      vote: vote
      }
  end
end
