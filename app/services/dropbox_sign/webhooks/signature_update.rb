# frozen_string_literal: true

module DropboxSign
  module Webhooks
    class SignatureUpdate
      def initialize(inbound_webhook)
        @inbound_webhook = inbound_webhook
        @signature_request_id = @inbound_webhook.body.dig("signature_request", "signature_request_id")
        @contract = Users::Contract.find_by(dropbox_sign_signature_request_id: @signature_request_id)
      end

      def self.call(*args)
        new(*args).call
      end

      def call
        result = Dropbox::Sign::SignatureRequestApi.new.signature_request_get(@signature_request_id)
        request = result.signature_request

        if request.has_error
          false
        else
          state = request.is_declined ? "declined" : "signed"
          @contract.update(state:)
          DropboxSign::Download.call(resource: @contract)
        end
      end
    end
  end
end
