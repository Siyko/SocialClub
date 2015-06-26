class CommentsController < ApplicationController
  # encoding: utf-8
  def create
    @task = Task.find_by_task_id(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    user = User.find(@task.user_id)
    if current_user.admin?
      UserMailer.admin_answer(user, @comment).deliver_later
    end
    redirect_to task_path(@task)
  end
  def destroy
    @task = Task.find_by_task_id(params[:task_id])
    @comment = @task.comments.find(params[:id])
    if @comment.user_id == current_user.id || current_user.admin?
      @comment.destroy
    else
      flash[:notice] = 'No permissions'
    end
    redirect_to task_path(@task)
  end
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
