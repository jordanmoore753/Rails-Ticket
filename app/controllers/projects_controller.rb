class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :is_logged_in, only: [:new, :edit, :create, :update, :destroy]

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def show
    @project = Project.find params[:id]
  end

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new project_params

    if @project.save
      flash[:success] = 'Project created successfully.'
      @project.reload
      redirect_to project_path @project.id
    else
      render 'new'
    end
  end

  def update
    @project = Project.find params[:id]

    if @project.update project_params
      flash[:success] = 'Project updated successfully.'
      redirect_to project_path @project.id
    else
      render 'edit'
    end 
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy

    flash[:success] = 'Project deleted successfully.'
    redirect_to projects_path
  end

  private

  def is_logged_in
    if current_user.nil?
      flash[:error] = 'Must be logged in to perform that action.'
      redirect_to projects_url
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
