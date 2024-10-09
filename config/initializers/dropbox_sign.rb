# frozen_string_literal: true

Dropbox::Sign.configure do |config|
  # Configure HTTP basic authorization: api_key
  config.username = Rails.application.credentials.hellosign_api_key

  # or, configure Bearer (JWT) authorization: oauth2
  # config.access_token = "YOUR_ACCESS_TOKEN"
end
