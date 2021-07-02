class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:alert] = "Already Logged In!"
      redirect_to tasks_path
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if current_user.admin?
         redirect_to admin_users_path
      else
      redirect_to user_path(user.id)
      end
    else
      flash.now[:danger] = 'login failed'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'logged out'
    redirect_to new_session_path
  end
end
