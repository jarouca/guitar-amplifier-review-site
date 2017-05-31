class ReviewsController < ApplicationController
before_action :authenticate_user!

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

def edit
  @amplifier = Amplifier.find(params[:id])
  @review = Review.find(params[:review_id])
end

def update
  @review = Review.find(params[:id])
  if @review.user_id == current_user.id || current_user.role == "admin"
    @review.update(review_params)
    @amplifier = Amplifier.find(params[:amplifier_id])

    if @review.save
      flash[:notice] = 'Review updated successfully'
      redirect_to @amplifier
    else
      render 'edit'
    end
  end
end

def destroy
  review = Review.find(params[:review_id])

  if review.user_id == current_user.id || current_user.role == "admin"



    if review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to amplifier_path
    end
  end
end


private

def review_params
  params.require(:review).permit(:body)
end

end
