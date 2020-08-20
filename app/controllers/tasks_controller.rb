class TasksController < ApplicationController
  before_action :set_user_id
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_path
    else
      # 失敗時の処理
    end
  end
  
  def index
    @tasks = Task.all
  end
  
  private
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
