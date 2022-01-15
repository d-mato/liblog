class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params.require(:session).permit(:email, :password))
    if user = @session.authenticate
      sign_in(user)
      redirect_to root_path
    else
      render :new, status: :unauthorized
    end
  end
end
