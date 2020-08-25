class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :show, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index]
  before_action :admin_or_correct_user, only: [:show]

  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def new
    @user = User.new
    if logged_in? && !current_user.admin?
      flash[:info] = "すでにログインしています。"
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_path
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_path
  end
  
  # beforeフィルター
  
  # ログイン中のユーザー本人、または管理者権限保有者かどうか判定
  def admin_or_correct_user
    @user = User.find(params[:id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to(root_url)
    end  
  end

  # 本人確認(アクセスユーザとcurrent_userのオブジェクトを比較)
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
