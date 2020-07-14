class SessionsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create]
  before_action :is_logged_in, only: [:destroy]

  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = 'Successfully logged in.'
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email and password combination.'
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end

  def not_logged_in
    if session[:user_id]
      flash[:error] = 'Already logged in.'
      redirect_to root_url
    end
  end

  def is_logged_in
    if !session[:user_id]
      flash[:error] = 'Must be logged in to perform that action.'
      redirect_to root_url
    end
  end
end
