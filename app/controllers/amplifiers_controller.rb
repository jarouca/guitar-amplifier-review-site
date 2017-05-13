class AmplifiersController < ApplicationController
  def new
    @amplifier = Amplifier.new
  end

  def create
    @amplifier = Amplifier.new(amplifier_params)

    if @amplifier.save
      flash[:notice] = "Amplifier submitted for review, thank you."
      redirect_to amplifiers_path
    else
      render :new
    end
  end

  def index
  end

  private

  def amplifier_params
    params.require(:amplifier).permit(
    :manufacturer,
    :model,
    :speaker,
    :tube_set
    )
  end
end
