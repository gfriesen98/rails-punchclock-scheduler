class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_privs] = user.position
      
      if user.name == 'punchclock'
        redirect_to punchclock_url, notice: "Logged In!"
      else
        redirect_to user, notice: "Logged In!"
      end
    else
      flash[:alert] = "Email or password is invalid!"
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_privs] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
