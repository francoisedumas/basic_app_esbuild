# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "browserless"
gem "cloudinary"
gem "dropbox-sign", "~> 1.4.1"
gem "httparty"
gem "devise-i18n"
gem "devise"
gem "enumerize"
gem "grover"
gem "image_processing", "~> 1.12"
gem "jsbundling-rails", "~> 1.3"
gem "pg", "~> 1.1"
gem "puma", "~> 6.4.3"
gem "rails-i18n", "~> 7.0.9"
gem "rails", "~> 7.1.4.1"
gem "redis", "~> 4.0"
gem "sass-rails"
gem "sidekiq-failures", "~> 1.0"
gem "sidekiq"
gem "simple_form", github: "heartcombo/simple_form"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "valvat"
gem "view_component"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "http"

group :development do
  gem "web-console"
end

group :development, :test do
  gem "bullet"
  gem "httplog"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop-rails", require: false
  gem "brakeman", require: false
  gem "bundle-audit", require: false

  # Those are dependancies of other gems. But we need to update them for security issues
  # Delete them only if the dependancies updated
  gem "rexml", "~> 3.3.6"
  gem "webrick", ">= 1.8.2"
end
