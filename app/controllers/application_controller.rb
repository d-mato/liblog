class ApplicationController < ActionController::Base
  private

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    if current_user.nil?
      redirect_to sign_in_path
    end
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_url, status: :unauthorized
    end
  end
end
