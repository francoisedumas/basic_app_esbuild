Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.base_controller_class = ['ApplicationController']
  config.lograge.custom_payload do |controller|
    {
      user_id: controller.current_user.try(:id)
    }
  end
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(password password_confirmation)
    {
      exception: event.payload[:exception], # ["ExceptionClass", "the message"]
      exception_object: event.payload[:exception_object], # the exception instance
      params: event.payload[:params].except(*exceptions)
    }
  end
end
