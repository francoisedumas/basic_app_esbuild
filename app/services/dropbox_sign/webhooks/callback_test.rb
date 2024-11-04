# frozen_string_literal: true

module DropboxSign
  module Webhooks
    class CallbackTest
      def initialize(inbound_webhook)
        @inbound_webhook = inbound_webhook
      end

      def self.call(*args)
        new(*args).call
      end

      def call
        Rails.logger.info("In the callback test service")

        true
      end
    end
  end
end
