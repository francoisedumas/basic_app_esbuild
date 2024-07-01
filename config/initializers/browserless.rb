# frozen_string_literal: true

# config/initializers/browserless.rb
def css_asset
  latest = if Rails.env.development?
      Rails.root.glob("app/assets/builds/tailwind.css").first
    else
      file_paths = Rails.root.glob("public/assets/application-*.css")
      file_paths.max_by { |p| File.mtime(p) }
    end
  File.read latest
end

Browserless.configure do |config|
  config.api_key = Rails.application.credentials.browserless_api
  config.style_tag = css_asset
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
