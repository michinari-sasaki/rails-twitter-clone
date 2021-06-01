class ApplicationController < ActionController::Base
  before_action :login_user

  def login_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def authenticate_user
    if @login_user == nil
      flash[:notice] = "ログインが必要です。"
      redirect_to("/login")
    else
    end
  end

  def user_auth
    if session[:user_id]
    else
      flash[:notice] = "ログインしてください"
      redirect_to("/login")
    end
  end

end
