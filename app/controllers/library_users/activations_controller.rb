class LibraryUsers::ActivationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library_user

  def create
    @library_user.update!(active: true)
    redirect_to library_users_url
  end

  def destroy
    @library_user.update!(active: false)
    redirect_to library_users_url
  end

  private

  def set_library_user
    @library_user = current_user.library_users.find(params[:library_user_id])
  end
end
