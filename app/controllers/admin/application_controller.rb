class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_admin_user!

  def index
    render 'admin/index'
  end

  def authenticate_admin_user!
    authenticate_user! # TODO: admin判定
  end
end
