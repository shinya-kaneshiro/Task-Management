class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # beforeフィルター
  
  # paramsハッシュからユーザーを取得する。
  def set_user_id
    @user = User.find(params[:user_id])
  end
  
  # ログインしていない場合、ログイン画面に導く
  def logged_in_user
    unless logged_in?
      # store_location
      # store_locationメソッドは実装しないかも。GETリクエストだったら記憶するやつね。
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  # 本人確認(アクセスユーザとcurrent_userのオブジェクトを比較)
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
  
  # 管理者権限を保有しているか判定する
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
end
