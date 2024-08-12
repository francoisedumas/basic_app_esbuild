# frozen_string_literal: true

module ApiClients
  class RestaurantsClient < Base
    def initialize(url, x_user_email, x_user_token)
      @url = url
      @x_user_email = x_user_email
      @x_user_token = x_user_token
    end

    private

    def default_headers(request)
      request['X-User-Email'] = @x_user_email if @x_user_email.present?
      request['X-User-Token'] = @x_user_token if @x_user_token.present?
    end
  end
end
