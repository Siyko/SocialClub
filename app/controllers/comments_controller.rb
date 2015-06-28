class CommentsController < ApplicationController
  # encoding: utf-8
  def create
    @task = Task.find_by_task_id(params[:task_id])
    user = User.find(@task.user_id)

    if current_user.admin?
      if @task.task_status_id = TaskStatus.find_by(status: 'New').id || @task.task_status_id = TaskStatus.find_by(status: 'QuestionAsked').id
        @task.task_status_id = TaskStatus.find_by(status: 'AnswerGiven').id
      end
      create_comment
      UserMailer.admin_answer(user, @comment).deliver_later
    else
      if @task.comments.empty? || !User.find(@task.comments.last.user_id).admin?
        flash[:notice] = 'Wait for answer'
        else
          create_comment
          @task.task_status_id = TaskStatus.find_by(status: 'QuestionAsked').id
      end
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

  def create_comment
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end
end
