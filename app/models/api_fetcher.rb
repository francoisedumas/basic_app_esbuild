# frozen_string_literal: true

############################################################
# Deprecated just kept for the first videos about Net:HTTP #
## See ApiClients::Base and ApiClients::RestaurantsClient ##
############################################################

class ApiFetcher
  def initialize(url, x_user_email, x_user_token)
    @url = url
    @x_user_email = x_user_email
    @x_user_token = x_user_token
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

  def make_request(klass, body: {}) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    uri = URI(@url)
    request = klass.new(uri)
    request["X-User-Email"] = @x_user_email if @x_user_email.present?
    request["X-User-Token"] = @x_user_token if @x_user_token.present?

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
end
