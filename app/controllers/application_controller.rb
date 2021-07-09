class ApplicationController < ActionController::Base
  before_action :get_current_user

  def get_current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def require_logged_in
    redirect_to sign_in_path, alert: "You must logged in to view that page" if @user.nil?
  end

  def require_admin
    redirect_to root_path, alert: "You need admin access to do that" if @user.nil? || @user.admin != true
  end
end
