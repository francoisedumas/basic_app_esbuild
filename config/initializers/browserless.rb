# frozen_string_literal: true

Browserless.configure do |config|
  config.api_key = Rails.application.credentials.browserless_api
  config.options = {
    format: "A4",
    print_background: true,
    margin: {
      bottom: "15mm",
      left: "10mm",
      right: "10mm",
      top: "0"
    }
  }
end
