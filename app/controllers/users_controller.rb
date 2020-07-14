class UsersController < ApplicationController
  before_action :not_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = 'User created successfully.'
      redirect_to login_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def not_logged_in
    if cookies[:user_id]
      flash[:error] = 'Already logged in.'
      redirect_to root_url
    end
  end
end
