class TasksController < ApplicationController
  before_action :set_user_id
  

  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_path
    else
      render :new
    end
  end

  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end

  def edit
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      render :edit
      # 今後、タスク詳細ページへリダイレクトする。
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_path
  end
  
  private
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
