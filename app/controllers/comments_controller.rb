class CommentsController < ApplicationController
  # encoding: utf-8
  def create
    @task = Task.find_by_task_id(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save#, :user_id => current_user.id)
    redirect_to task_path(@task)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end