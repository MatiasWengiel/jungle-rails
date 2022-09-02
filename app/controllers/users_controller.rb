class UsersController < ApplicationController
  def new
    if session[:user_id]
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else  
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
  end
end