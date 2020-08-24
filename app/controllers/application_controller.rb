class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # beforeフィルター
  
  # paramsハッシュからユーザーを取得する。
  def set_user_id
    @user = User.find(params[:user_id])
  end
  
  def logged_in_user
    unless logged_in?
      # store_location
      # store_locationメソッドは実装しないかも。GETリクエストだったら記憶するやつね。
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
end
