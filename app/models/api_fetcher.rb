# frozen_string_literal: true

class ApiFetcher
  def initialize(url)
    @url = url
  end

  def fetch
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    { error: e.message }
  end
end
