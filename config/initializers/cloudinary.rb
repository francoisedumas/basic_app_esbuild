# frozen_string_literal: true

unless Rails.env.test?
  Cloudinary.config do |config|
    config.cloud_name = Rails.application.credentials.cloudinary[:cloud_name]
    config.api_key = Rails.application.credentials.cloudinary[:api_key]
    config.api_secret = Rails.application.credentials.cloudinary[:api_secret]
    config.secure = true
    config.cdn_subdomain = true
  end
end
