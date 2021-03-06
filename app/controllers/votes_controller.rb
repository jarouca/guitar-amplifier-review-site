class VotesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    review = Review.find(params[:id])
    @amplifier = Amplifier.find(review.amplifier_id)

    if Vote.find_by(user_id: current_user.id, review_id: params[:id])
      Vote.find_by(user_id: current_user.id, review_id: params[:id]).destroy
      redirect_to @amplifier and return
    else
      redirect_to @amplifier
    end
  end

  def create
    @amplifier = Amplifier.find(params[:amplifier_id])
    #if user already voted on this review, set previous vote as vote variable
    if Vote.find_by(user_id: current_user.id, review_id: params[:review_id])
      vote = Vote.find_by(user_id: current_user.id, review_id: params[:review_id])
      #if user's new vote does not match their previous vote
      if params[:up_vote] != vote.up_vote.to_s
      # change vote's up_vote attribute to match most recent vote
        vote.toggle!(:up_vote)
        @up_votes = Vote.where(review_id: params[:review_id], up_vote: true).count
        @down_votes = Vote.where(review_id: params[:review_id], up_vote: false).count
        redirect_to @amplifier and return
      else #redirect back to amplifier show page without changing vote and without creating an additional vote (user cannot vote twice)
        @up_votes = Vote.where(review_id: params[:review_id], up_vote: true).count
        @down_votes = Vote.where(review_id: params[:review_id], up_vote: false).count
        redirect_to @amplifier and return
      end
    #elsif user has not previously voted on this review, and they down voted, create vote with down vote attribute
    elsif params[:up_vote] == "false"
      vote = Vote.new(review_id: params[:review_id],
      user_id: current_user.id, up_vote: false)
    else #create vote with up vote attribute
      vote = Vote.new(review_id: params[:review_id],
      user_id: current_user.id)
    end

    if vote.save
      @up_votes = Vote.where(review_id: params[:review_id], up_vote: true).count
      @down_votes = Vote.where(review_id: params[:review_id], up_vote: false).count
      redirect_to @amplifier
    end
  end
end
