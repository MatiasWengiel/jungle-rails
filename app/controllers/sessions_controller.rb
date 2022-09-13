class SessionsController < ApplicationController

  def new
    #If user atttempts to go to /login while logged in, redirect to root
    if session[:user_id]
      redirect_to '/'
    end
  end

  def create
    #If user exists, authenticate. If either fails, redirect to /login
    if user && User.authenticate_with_credentials(email, params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    elsif
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
