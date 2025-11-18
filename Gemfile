# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.7"

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
gem "rails", "~> 7.2.2", ">= 7.2.2.2"
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
gem "lograge"
# Add gem to ensure the proper version
gem "webrick", "~> 1.8.2"
gem "rexml", "~> 3.4.2"

# FIXME: supprimer cette dépendance explicite dès que possible
# NOTE: CVE-2025-61594: URI Credential Leakage Bypass over CVE-2025-27221
gem "uri", "~> 1.0", ">= 1.0.4"

# NOTE: Nokogiri patches vendored libxml2 to resolve multiple CVEs
# GHSA-353f-x4gh-cqq8
# @see https://github.com/sparklemotion/nokogiri/security/advisories/GHSA-353f-x4gh-cqq8
# FIXME: supprimer cette dépendance explicite dès que possible
gem "nokogiri", "~> 1.18", ">= 1.18.9"

# NOTE: Thor can construct an unsafe shell command from library input.
# CVE-2025-54314
# GHSA-mqcp-p2hv-vw6x
# @see https://github.com/advisories/GHSA-mqcp-p2hv-vw6x
# FIXME: supprimer cette dépendance explicite dès que possible
gem "thor", "~> 1.4"

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
  gem "lookbook", ">= 2.3.8"
  gem "listen"
end
