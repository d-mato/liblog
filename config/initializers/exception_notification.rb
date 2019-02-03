if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotification::Rack,
                                          email: {
                                              email_prefix: '[liblog] ',
                                              sender_address: %{"notifier" <exception@liblog>},
                                              exception_recipients: %w{telnetstat@gmail.com}
                                          }
end
