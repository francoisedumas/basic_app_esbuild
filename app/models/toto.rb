# frozen_string_literal: true

class Toto
  def self.lolo
    true if Rails.application.credentials.dumb_key
  end
end
