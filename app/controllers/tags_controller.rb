class TagsController < ApplicationController
  include ApplicationHelper
  before_action :is_logged_in, only: [:new, :create, :update, :destroy, :edit]
  
  def new

  end

  def edit

  end
  
  def create

  end

  def update

  end

  def destroy

  end

  private

  def is_logged_in
    if current_user.nil?
      flash[:error] = 'Must be logged in to perform that action.'
      redirect_to root_url
    end
  end
end
