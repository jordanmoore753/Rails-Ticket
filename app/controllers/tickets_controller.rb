class TicketsController < ApplicationController
  include ApplicationHelper
  before_action :is_logged_in, only: [:new, :create, :update, :destroy, :edit]

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find params[:id]
  end

  def show
    @ticket = Ticket.find params[:id]
  end

  def index
    @tickets = Ticket.all 
  end

  def create
    @ticket = Ticket.new ticket_params

    if @ticket.save
      @ticket.reload
      flash[:success] = 'Ticket created successfully.'
      redirect_to ticket_path @ticket
    else
      render 'new'
    end
  end

  def update
    @ticket = Ticket.find params[:id]

    if @ticket.update ticket_params
      flash[:success] = 'Ticket updated successfully.'
      redirect_to ticket_path @ticket.id
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find params[:id]
    @ticket.destroy

    flash[:success] = 'Ticket destroyed successfully.'
    redirect_to tickets_path
  end

  private

  def is_logged_in
    if current_user.nil?
      flash[:error] = 'Must be logged in to perform that action.'
      redirect_to tickets_url
    end
  end

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :assignee, :project_id)
  end
end
