class CommentsController < ApplicationController
  include ApplicationHelper
  before_action :is_correct_user, only: [:edit, :update, :destroy]
  before_action :is_logged_in, only: [:create]

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]

    if @comment.update comment_params.merge(creator_id: current_user.id, ticket_id: params[:ticket_id])
      flash[:success] = 'Comment successfully updated.'
      redirect_to ticket_path params[:ticket_id]
    else
      flash.now[:error] = 'There was a problem while updating the comment.'
      render 'tickets/show'
    end
  end

  def create
    @comment = Comment.new comment_params.merge(creator_id: current_user.id, ticket_id: params[:ticket_id])
    
    if @comment.save
      if params[:status].present?
        @ticket = Ticket.find params[:ticket_id]
        @ticket.update_attribute(:status, params[:status])
      end

      flash[:success] = 'Successfully created comment.'
      redirect_to ticket_path params[:ticket_id]
    else
      flash.now[:error] = 'Could not create the comment.'
      render 'tickets/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = 'Comment successfully deleted.'
    redirect_to ticket_path params[:ticket_id]
  end

  private

  def is_correct_user
    @comment = Comment.find params[:id]

    if @comment.creator_id != session[:user_id]
      flash[:error] = 'You are not the authorized user.'
      redirect_to ticket_path params[:ticket_id]
    end
  end

  def is_logged_in
    if current_user.nil?
      flash[:error] = "Must be logged in to perform that action."
      redirect_to ticket_path params[:ticket_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
