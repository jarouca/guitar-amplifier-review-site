class AmplifiersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorize_user, except: [:index, :show, :new, :create]

  def destroy
    amplifier = Amplifier.find(params[:id])

    if amplifier.user_id == current_user.id || current_user.role == "admin"
      Review.where(amplifier_id: amplifier).destroy_all

      if amplifier.destroy
        flash[:notice] = 'Amplifier deleted successfully.'
        redirect_to root_path
      end
    end
  end

  def show
    @amplifier = Amplifier.find(params[:id])
    @reviews = Review.where(amplifier: @amplifier).includes(:votes)
  end

  def new
    @amplifier = Amplifier.new
    @user = current_user
  end

  def create
    @amplifier = Amplifier.new(amplifier_params)
    @amplifier.user_id = params[:user_id]

    if @amplifier.save
      flash[:notice] = "Amplifier submitted for review, thank you."
      redirect_to amplifiers_path
    else
      render :new
    end
  end

  def edit
    @amplifier = Amplifier.find(params[:id])

    @user = current_user
  end

  def update
    @amplifier = Amplifier.find(params[:id])
    @amplifier.update(amplifier_params)

    if @amplifier.save
      flash[:notice] = 'Amplifier edited successfully'
      redirect_to @amplifier
    else
      render 'edit'
    end
  end

  def index
    if params[:search]
      @amplifiers = Amplifier.where("manufacturer ILIKE ?", params[:search])
    else
      @amplifiers = Amplifier.order(id: :desc)
    end
  end

  private

  def amplifier_params
    params.require(:amplifier).permit(
    :manufacturer,
    :model,
    :speaker,
    :tube_set,
    )
  end
  
end
