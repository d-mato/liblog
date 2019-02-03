namespace :crawler do
  desc 'Execute crawler for all accounts'
  task exec: :environment do
    LibraryUser.active.pluck(:id).each do |id|
      CrawlerJob.perform_now(id)
    rescue => e
      ExceptionNotifier.notify_exception(
          e,
          env: request.env
      )
    end
  end
end
