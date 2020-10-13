class WelcomeController < ApplicationController

  def index
    user = User.where(id: "#{session[:user_id]}").take
    if user != nil
      redirect_to user, notice: "Logged In!"
    end
  end

  def create
    
  end

end
