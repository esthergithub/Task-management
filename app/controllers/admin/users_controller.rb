class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :name, :email, :admin).order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "new user added"
      redirect_to admin_users_path(@user.id)
    else
      flash.now[:danger] = "User registration failed"
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id).page(params[:page]).per(5)
  end

  def edit
  end

  def update
    puts @user
    if @user.update(user_params)
      flash[:success] = "update successful"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if (current_user == user) && (current_user.admin?)
    flash[:error] = "You cannot delete own admin account!"
    redirect_to admin_users_path
    elsif @user.destroy
      flash[:success] = "user deleted!"
      redirect_to admin_users_path
    else
      flash[:danger] = "user not deleted!"
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def  if_not_admin
    redirect_to  tasks_path(current_user.id)  unless  current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :title)
  end
end
