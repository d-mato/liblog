class ExtensionJob < ApplicationJob
  queue_as :default

  def perform(loan)
    notifier = Slack::Notifier.new(Rails.application.credentials.dig(:slack, :webhook_url))
    library_user = loan.user.library_users.find_by!(library: loan.library)
    crawler = loan.library.crawler.constantize.new(id: library_user.sign_in_id, password: library_user.password)
    crawler.login
    crawler.extend_loan(loan.book_title)
    CrawlerJob.perform_now(library_user.id)

    loan.reload
    notifier.post(text: '延長処理に成功しました', attachments: [loan_data(loan)])
  rescue Crawler::CannotExtendError
    notifier.post(text: '延長処理に失敗しました', attachments: [loan_data(loan)])
  rescue => e
    ExceptionNotifier.notify_exception(e)
  ensure
    crawler.quit
  end

  private

  def loan_data(loan)
    { title: loan.book_title, text: "貸出日 #{loan.started_at.strftime('%-m月%-d日')}\n返却日 #{loan.ended_at.strftime('%-m月%-d日')}" }
  end
end
