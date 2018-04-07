class LoansController < ApplicationController
  before_action :authenticate_user!

  def index
    @loans = current_user.loans.eager_load(:library).order(ended_at: :desc)
  end

  def show
    @loan = current_user.loans.find(params[:id])
  end
end
