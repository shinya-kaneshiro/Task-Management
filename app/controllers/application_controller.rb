class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # beforeフィルター
  
  # paramsハッシュからユーザーを取得する。
  def set_user_id
    @user = User.find(params[:user_id])
  end
  
end
