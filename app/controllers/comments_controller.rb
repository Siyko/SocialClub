class CommentsController < ApplicationController
       def create
       @task = Task.find_by_task_id(params[:task_id])
       @comment = @task.comments.new(comment_params)
       @comment.user_id = current_user.id
       @comment.save
          redirect_to task_path(@task)
         end
         def destroy
             @task = Task.find_by_task_id(params[:task_id])
             @comment = @task.comments.find(params[:id])
             if @comment.user_id == current_user.id
                      @comment.destroy
                    else
                             flash[:notice] = 'You have no permissions!'
             end
             redirect_to task_path(@task)
     end
    private
   def comment_params
       params.require(:comment).permit(:body, attachments_attributes:[:attachment])
     end
  end