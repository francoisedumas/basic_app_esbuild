# frozen_string_literal: true

module Webhooks
  class BaseController < ActionController::API
    # skip_before_action :verify_authenticity_token
    before_action :verify_event

    def create
      InboundWebhook.create(body: payload)
      head :ok
    end

    private

    def verify_event
      head :bad_request
    end

    def payload
      @payload ||= JSON.parse(params[:json])
    end
  end
end
