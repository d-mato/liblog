class NotificationMailer < ApplicationMailer
  # 返却日お知らせ
  def return_date(user:, loans:)
    @loans = loans
    mail(to: user.email, subject: '返却日が近づいています')
  end
end
