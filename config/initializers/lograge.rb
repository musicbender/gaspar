Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = 'ActionController::API'
  config.lograge.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new($stdout))
end