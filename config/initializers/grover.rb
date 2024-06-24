# frozen_string_literal: true

# config/initializers/grover.rb
Grover.configure do |config|
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
