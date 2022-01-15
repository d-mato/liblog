namespace :notifier do
  desc 'Notify return date'
  task return_date: :environment do
    User.find_each do |user|
      target_date = Date.tomorrow
      # 明日が返却期限のもの
      loans = user.loans.where(returned: false, ended_at: target_date)

      if loans.present?
        notifier = Slack::Notifier.new(Rails.application.credentials.dig(:slack, :webhook_url))
        notifier.post(
          text: '返却日が近い本をお知らせします',
          attachments: loans.map { |loan|
            {
              title: "#{loan.book_title} @#{loan.library.name}",
              text: "貸出日 #{loan.started_at.strftime('%-m月%-d日')}\n返却日 #{loan.ended_at.strftime('%-m月%-d日')}"
            }
          }
        )
      end
    end
  end
end
