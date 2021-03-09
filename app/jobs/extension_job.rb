class ExtensionJob < ApplicationJob
  queue_as :default

  def perform(loan)
    library_user = loan.user.library_users.find_by!(library: loan.library)
    crawler = loan.library.crawler.constantize.new(id: library_user.sign_in_id, password: library_user.password)
    crawler.login
    begin
      crawler.extend_loan(loan.book_title)
      CrawlerJob.perform_later(library_user.id)
    rescue Crawler::CannotExtendError
      # TODO: 通知
    end
  end
end
