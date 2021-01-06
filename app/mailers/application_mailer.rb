class ApplicationMailer < ActionMailer::Base
  default from: 'liblog@liblog'
  layout 'mailer'
  helper ApplicationHelper
end
