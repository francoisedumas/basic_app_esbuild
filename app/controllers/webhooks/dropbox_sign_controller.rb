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

    def payload
      @payload ||= begin
        parsed_params = JSON.parse(params.require(:json))
        ActionController::Parameters.new(parsed_params).
          permit(
            signature_request: [
              :signature_request_id,
              { metadata: [:kind] }
            ],
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
