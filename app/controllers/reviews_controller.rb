class ReviewsController < ApplicationController

def new
  @amplifier = Amplifier.find(params[:amplifier_id])
  @review = Review.new
end

def create
  @amplifier = Amplifier.find(params[:amplifier_id])
  @review = Review.new(review_params)
  @review.user_id = current_user.id
  @review.amplifier = @amplifier

  if @review.save
    flash[:notice] = 'Review submitted successfully'
    redirect_to @amplifier
  else
    flash[:alert] = "Failed to save review"
    render :new
  end

end



private

def review_params
  params.require(:review).permit(:body)
end

end
