namespace :notifier do
  desc 'Notify return date'
  task return_date: :environment do
    User.find_each do |user|
      target_date = Date.tomorrow
      # 明日が返却期限のもの
      loans = user.loans.where(returned: false, ended_at: target_date)

      if loans.present?
        NotificationMailer.return_date(user: user, loans: loans).deliver_now
      end
    end
  end
end
