# frozen_string_literal: true

module Webhooks
  class DropboxSignController < BaseController
    ALLOWED_IPS = [
      "2600:1f18:20d2:4c00",
      "34.200.190.67",
      "44.216.219.123",
      "34.198.205.50",
      "184.73.232.209",
      "3.229.107.48",
      "34.198.117.22",
      "2600:1f16:89:4700",
      "3.17.43.141",
      "13.59.145.12",
      "3.135.245.223",
      "3.23.150.114"
    ].freeze

    EVENT_TYPE = {
      "signature_request_all_signed" => DropboxSign::Webhooks::SignatureUpdate,
      "callback_test" => DropboxSign::Webhooks::CallbackTest
    }.freeze

    def create
      record = InboundWebhook.create(body: payload)
      kind = record.body.dig("event", "event_type")

      EVENT_TYPE[kind].call(record) unless kind.nil?

      render plain: "Hello API Event Received", status: :ok
      # Dropbox Sign Webhooks API ask explicitly for a payload with the string 'Hello API Event Received'
      # Source : https://developers.hellosign.com/docs/events/walkthrough/#responding-to-events
    end

    private

    def payload
      @payload ||= begin
        parsed_params = JSON.parse(params.require(:json))
        ActionController::Parameters.new(parsed_params).
          permit(
            signature_request: [:signature_request_id],
            event: [:event_type]
          )
      end
    end

    def verify_event
      verify_ip_address
      verify_secret
    end

    def verify_ip_address
      render plain: "Not found", status: :not_found unless ALLOWED_IPS.include?(request.remote_ip)
    end

    def verify_secret
      callback_data = JSON.parse(request.params[:json], symbolize_names: true)
      callback_event = Dropbox::Sign::EventCallbackRequest.init(callback_data)

      return if Dropbox::Sign::EventCallbackHelper.is_valid(api_key, callback_event)

      render plain: "Not found", status: :not_found
    end

    def api_key
      Rails.application.credentials.hellosign_api_key
    end
  end
end
