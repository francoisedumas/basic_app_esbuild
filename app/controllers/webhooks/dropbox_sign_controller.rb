# frozen_string_literal: true

module Webhooks
  class DropboxSignController < BaseController
    def create
      record = InboundWebhook.create(body: payload)
      if record.body.dig("event", "event_type") == "callback_test"
        render(plain: "Hello API Event received", status: :ok)
      else
        render(plain: "Issue", status: :internal_server_error)
      end
    end

    private

    def verify_event
      nil
    end
  end
end
