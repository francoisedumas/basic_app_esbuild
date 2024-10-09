# frozen_string_literal: true

module ApiClients
  class Base
    def initialize(url, token = "")
      @url = url
      @token = token
    end

    def get
      make_request Net::HTTP::Get
    end

    def delete
      make_request Net::HTTP::Delete
    end

    def post(body)
      make_request Net::HTTP::Post, body:
    end

    def patch(body)
      make_request Net::HTTP::Patch, body:
    end

    def put(body)
      make_request Net::HTTP::Put, body:
    end

    private

    def make_request(klass, body: {}) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      uri = URI(@url)
      request = klass.new(uri)
      default_headers(request)

      if body.present?
        request["Content-Type"] = "application/json"
        request.body = body.to_json
      end

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true if uri.scheme == "https"

      response = http.request(request)

      JSON.parse(response.body)
    rescue StandardError => e
      { error: e.message }
    end

    def default_headers(request)
      return if @token.blank?

      request["Authorization"] = "Bearer #{@token}"
    end
  end
end
