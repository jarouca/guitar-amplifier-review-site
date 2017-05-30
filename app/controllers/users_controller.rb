class UsersController < ApplicationController

  def destroy
    @users = User.where.not(id: current_user.id)
    user = User.find(params[:id])

    if user.destroy
      flash[:notice] = 'User successfully deleted'
      render :index
    end
  end

  def index
    @users = User.where.not(id: current_user.id)

    render :index
  end


  def show
  end
end
