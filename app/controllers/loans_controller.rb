class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: %i[show set_returned]

  def index
    @loans = current_user.loans.includes(:library, :book_review).order(ended_at: :desc)

    if (@q = params[:q]).present?
      pattern = "%#{@q}%"
      condition = [
        Loan.arel_table[:book_title].matches(pattern),
        Loan.arel_table[:author].matches(pattern),
        BookReview.arel_table[:comment].matches(pattern)
      ].inject { |memo, c| memo.or(c) }
      @loans = @loans.eager_load(:book_review).where(condition)
    end
  end

  def show; end

  def calendar; end

  # 返却済みにする
  def set_returned
    @loan.update!(returned: true)
    redirect_to @loan, notice: '返却済みにしました'
  end

  private

  def set_loan
    @loan = current_user.loans.find(params[:id])
  end
end
