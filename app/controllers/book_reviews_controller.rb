class BookReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan

  def create
    @loan.create_book_review!(book_review_params)
    redirect_to @loan, notice: 'レビューを更新しました！'
  end

  def update
    @loan.book_review.update!(book_review_params)
    redirect_to @loan, notice: 'レビューを更新しました！'
  end

  private

  def set_loan
    @loan = current_user.loans.find(params[:loan_id])
  end

  def book_review_params
    params.require(:book_review).permit(%i(comment star))
  end
end
