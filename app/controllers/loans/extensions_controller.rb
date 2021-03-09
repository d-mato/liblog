class Loans::ExtensionsController < ApplicationController
  before_action :authenticate_user!

  def create
    loan = current_user.loans.find(params[:loan_id])
    ExtensionJob.perform_later(loan)
    redirect_to loan, notice: '延長処理を実行中です. 返却期限は後ほど更新されます'
  end
end
