# frozen_string_literal: true

class ApiFetcher
  def initialize(url, x_user_email, x_user_token)
    @url = url
    @x_user_email = x_user_email
    @x_user_token = x_user_token
  end

  def get
    make_request Net::HTTP::Get
  end

  def post(body)
    make_request Net::HTTP::Post, body:
  end

  def make_request(klass, body: {})
    uri = URI(@url)
    request = klass.new(uri)
    request['X-User-Email'] = @x_user_email if @x_user_email.present?
    request['X-User-Token'] = @x_user_token if @x_user_token.present?

    if body.present?
      request['Content-Type'] = 'application/json'
      request.body = body.to_json
    end

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    response = http.request(request)

    JSON.parse(response.body)
  rescue StandardError => e
    { error: e.message }
  end
end
