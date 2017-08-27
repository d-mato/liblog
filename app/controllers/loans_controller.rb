class LoansController < ApplicationController
  before_action :authenticate_user!

  def index
    @loans = current_user.loans
  end
end
