namespace :crawler do
  desc 'Execute crawler for all accounts'
  task exec: :environment do
    LibraryUser.pluck(:id).each { |id| CrawlerJob.perform_now(id) }
  end
end
