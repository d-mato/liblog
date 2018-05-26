class CrawlerJob < ApplicationJob
  queue_as :default

  def perform(library_user_id)
    library_user = LibraryUser.find(library_user_id)
    library = library_user.library
    crawler = library.crawler.constantize.new(id: library_user.sign_in_id, password: library_user.password)

    crawler.login
    library_user.call_signed_in!

    now = Time.current
    ActiveRecord::Base.transaction do
      # 一旦既存の貸出を全て返却済みにする
      library_user.loans.update_all(returned: true)

      crawler.fetch_loans.each do |obj|
        loan = library_user.loans.find_or_initialize_by(started_at: obj[:started_at], book_title: obj[:book_title])

        loan.attributes = obj.slice(:place_name, :ended_at, :author, :isbn)
        loan.attributes = { last_fetched_at: now, returned: false }
        loan.user ||= library_user.user
        loan.save!
      end
    end
  end
end
