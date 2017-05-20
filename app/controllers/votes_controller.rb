class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:up_vote] == "false"
      vote = Vote.new(review_id: params[:review_id],
      user_id: current_user.id, up_vote: false)
    else
      vote = Vote.new(review_id: params[:review_id],
      user_id: current_user.id)
    end

    @amplifier = Amplifier.find(params[:amplifier_id])

    if vote.save
      redirect_to @amplifier
    end
  end

  def edit
  end
end
  #if user down voted and user hasn't voted at all yet:

  #if user up voted and user hasn't voted at all yet:
  #if user changes up vote to down vote
  #if user changes down vote to up vote

  #if user up votes but already up voted

  #if user down voted but already down voted
