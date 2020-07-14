class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :is_logged_in, only: [:new, :edit, :create, :update, :destroy]

  def new

  end

  def edit

  end

  def show

  end

  def index

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
