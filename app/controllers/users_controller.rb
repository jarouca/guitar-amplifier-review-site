class UsersController < ApplicationController

  def destroy
    if current_user.role == "admin"
      @users = User.where.not(id: current_user.id)
      user = User.find(params[:id])

      if user.destroy
        flash[:notice] = 'User successfully deleted'
        render :index
      end
    end
  end

  def index
    if current_user.role == "admin"
      @users = User.where.not(id: current_user.id)

        render :index
      end
    end

end
