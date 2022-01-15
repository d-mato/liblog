config = {
  ignore_if: ->(env, exception) { !Rails.env.production? },
  slack: {
    webhook_url: Rails.application.credentials.dig(:slack, :webhook_url)
  }
}
Rails.application.config.middleware.use ExceptionNotification::Rack, config
