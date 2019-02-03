class ApplicationMailer < ActionMailer::Base
  default from: 'liblog@liblog'
  layout 'mailer'
  add_template_helper(ApplicationHelper)
end
