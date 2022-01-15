class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path
    else
      @email = params[:email]
      @error_message = 'ログインできませんでした'
      render :new, status: :unauthorized
    end
  end
end
