class UsersController < ApplicationController
  def index
    @user = User.where(admin: false)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_index_path, notice: "User was successfully created." }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin, :name, :designation)
  end
end
