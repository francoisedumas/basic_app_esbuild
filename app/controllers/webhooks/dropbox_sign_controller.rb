# frozen_string_literal: true

module Webhooks
  class DropboxSignController < BaseController
    EVENT_TYPE = {
      "contract" => DropboxSign::Webhooks::SignatureUpdate
    }.freeze
    def create
      record = InboundWebhook.create(body: payload)
      kind = record.body.dig("signature_request", "metadata", "kind")
      if EVENT_TYPE[kind].new(record).call
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
