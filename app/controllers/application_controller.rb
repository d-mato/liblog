class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_url, status: :unauthorized
    end
  end
end
