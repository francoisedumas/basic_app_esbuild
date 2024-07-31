# frozen_string_literal: true

module DropboxSign
  module Webhooks
    class CallbackTest
      def initialize(inbound_webhook)
        @inbound_webhook = inbound_webhook
      end

      def call
        true
      end
    end
  end
end
