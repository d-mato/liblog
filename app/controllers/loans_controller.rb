class LoansController < ApplicationController
  before_action :authenticate_user!

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

  def show
    @loan = current_user.loans.find(params[:id])
  end

  def calendar; end

  # 延長
  def extend_loan
    loan = current_user.loans.find(params[:id])
    library_user = current_user.library_users.find_by!(library: loan.library)
    crawler = loan.library.crawler.constantize.new(id: library_user.sign_in_id, password: library_user.password)

    crawler.login

    begin
      crawler.extend_loan(loan.book_title)
      CrawlerJob.perform_later(library_user.id)
      redirect_to loan, notice: '延長しました！返却期限は後ほど更新されます'
    rescue Crawler::CannotExtendError
      redirect_to loan, alert: '延長処理に失敗しました。お手数ですが図書館Webサイトにログインして確認してください。'
    end
  end
end
