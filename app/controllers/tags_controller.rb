class TagsController < ApplicationController
  include ApplicationHelper
  before_action :is_logged_in, only: [:new, :create, :update, :destroy, :edit]
  
  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find params[:id]
  end
  
  def create
    @tag = Tag.new tag_params

    if @tag.save
      flash[:success] = 'Tag successfully created.'
      redirect_to tags_url
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find params[:id]

    if @tag.update tag_params
      flash[:success] = "Tag updated successfully."
      redirect_to tags_url
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.destroy

    flash[:success] = 'Tag deleted successfully.'
    redirect_to tags_url
  end

  private

  def is_logged_in
    if current_user.nil?
      flash[:error] = 'Must be logged in to perform that action.'
      redirect_to tags_url
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
