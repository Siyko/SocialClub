class TasksController < ApplicationController
  before_action :check_user, only: [:show, :edit]
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by_task_id(params[:id])
    if !@task
      redirect_to tasks_path, :notice => 'Task not found'
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find_by_task_id(params[:id])
  end

  def create
    sid = generate_id('A'..'Z')
    sid << '-'
    sid << generate_id(0..9)
    sid << '-'
    sid << generate_id('A'..'Z')
    sid << '-'
    sid << generate_id(0..9)
    @task = Task.new(task_params)
    @task.task_id = sid
    @task.user_id = current_user.id
    @task.task_status_id = TaskStatus.find_by_status('New').id
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find_by_task_id(params[:id])
    if @task.user_id != current_user.id
      redirect_to tasks_path, :notice => 'You have no permissions to edit this task!'
    else
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
      end
  end



  private
  def check_user
    @task = Task.find_by_task_id(params[:id])
    if @task.user_id != current_user.id
      redirect_to tasks_path, flash: {:notice => 'No permissions!'}
    end
  end
  def task_params
    params.require(:task).permit(:title, :text, :attachment)
  end
  def generate_id(params)
    3.times.map { (params).to_a.sample }.join
  end

end
