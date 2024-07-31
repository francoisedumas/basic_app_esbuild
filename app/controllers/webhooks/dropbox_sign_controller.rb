# frozen_string_literal: true

module Webhooks
  class DropboxSignController < BaseController
    EVENT_TYPE = {
      "contract" => DropboxSign::Webhooks::SignatureUpdate,
      "callback_test" => DropboxSign::Webhooks::CallbackTest
    }.freeze
    def create
      record = InboundWebhook.create(body: payload)
      kind = record.body.dig("signature_request", "metadata", "kind") || record.body.dig("event", "event_type")
      if kind.nil?
        # Dropbox Sign Webhooks API ask explicitly for a payload with the string 'Hello API Event Received'
        # Source : https://developers.hellosign.com/docs/events/walkthrough/#responding-to-events
        render(plain: "Hello API Event Received", status: :ok)
      elsif EVENT_TYPE[kind].new(record).call
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
