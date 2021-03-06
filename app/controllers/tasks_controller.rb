class TasksController < ApplicationController
  before_action :set_user_id
  before_action :logged_in_user
  before_action :correct_user


  def index
    @tasks = Task.where(user_id: current_user.id).order(created_at: :desc)
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
      redirect_to user_task_path
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
  
  # beforeフィルター
  
  # 本人確認(アクセスユーザとcurrent_userのオブジェクトを比較)
  def correct_user
    @user = User.find(params[:user_id])
    if !current_user?(@user)
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end  

  
  private
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
