class LoansController < ApplicationController
  before_action :authenticate_user!

  def index
    @loans = current_user.loans.includes(:library, :book_review).order(ended_at: :desc)

    @q = params[:q]
    if @q.present?
      pattern = "%#{@q}%"
      condition = [
        Loan.arel_table[:book_title].matches(pattern),
        Loan.arel_table[:author].matches(pattern),
        BookReview.arel_table[:comment].matches(pattern)
      ].inject { |memo, c| memo.or(c) }
      @loans = @loans.eager_load(:book_review).where(condition)
    end
  end

  def show
    @loan = current_user.loans.find(params[:id])
  end
end
