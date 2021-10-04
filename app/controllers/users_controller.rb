class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :add_index_breadcrumb, only: [:show, :edit, :new]
  def index 
    @user = User.where(admin: false).order(:id)
    add_breadcrumbs('All Users')
  end
  
  def new
    @user = User.new
    add_breadcrumbs('New User')
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "User was created successfully."
      redirect_to users_path
    else
      render "new"
    end
  end

  def show
    add_breadcrumbs(@user.name)
  end

  def edit
    add_breadcrumbs("Edit/"+@user.name)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, alert: "User was successfully destroyed." }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin, :name, :designation)
  end
  
  def set_user
  @user = User.find(params[:id])
  end

  def add_index_breadcrumb
    add_breadcrumbs('All Users', users_path)
  end
end
