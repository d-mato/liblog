namespace :crawler do
  desc 'Execute crawler for all accounts'
  task exec: :environment do
    LibraryUser.active.pluck(:id).each { |id| CrawlerJob.perform_later(id) }
  end
end
