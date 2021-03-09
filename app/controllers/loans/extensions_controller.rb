class Loans::ExtensionsController < ApplicationController
  before_action :authenticate_user!

  def create
    loan = current_user.loans.find(params[:loan_id])
    # TODO: ActiveJobにする
    library_user = current_user.library_users.find_by!(library: loan.library)
    crawler = loan.library.crawler.constantize.new(id: library_user.sign_in_id, password: library_user.password)
    crawler.login
    begin
      crawler.extend_loan(loan.book_title)
      redirect_to loan, notice: '延長しました！返却期限は後ほど更新されます'
    rescue Crawler::CannotExtendError
      redirect_to loan, alert: '延長処理に失敗しました。お手数ですが図書館Webサイトにログインして確認してください。'
    end
  end
end
