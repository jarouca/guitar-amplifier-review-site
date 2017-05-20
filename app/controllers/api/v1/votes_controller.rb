class Api::V1::VotesController < Api::V1::ApiController
  def create
    binding.pry
    vote = Vote.new(vote_params)
    if vote.save
      render json: :nothing, status: :created, location: api_v1_votes_path(vote)
    else
      render json: :nothing, status: :not_found
    end
  end

  def index
    if params[:review_id]
      review = Review.find(params[:review_id])
      votes = Vote.where(review: review)
    end

    render json: votes
  end

  private
  def vote_params
    params.require(:vote).permit(:review_id, :user_id)
  end

end
