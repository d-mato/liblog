class CrawlerJob < ApplicationJob
  queue_as :default

  def perform(library_user_id)
    library_user = LibraryUser.find(library_user_id)
    library = library_user.library
    crawler = library.crawler.constantize.new(library_user)
    crawler.exec
  end
end
