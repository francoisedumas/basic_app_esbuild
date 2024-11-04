# frozen_string_literal: true

RSpec.describe Webhooks::DropboxSignController, type: :request do
  describe "POST #create" do
    let(:api_key) { "mocked-api-key" }
    let(:event_type) { "signature_request_all_signed" }
    let(:event_time) { Time.now.to_i.to_s }
    let(:mock_event_hash) do
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), api_key, "#{event_time}#{event_type}")
    end
    let(:payload) do
      {
        event: {
          event_hash: mock_event_hash,
          event_type:,
          event_time:
        },
        signature_request: { signature_request_id: "12345" }
      }
    end

    subject { post webhooks_dropbox_sign_path, params: { json: payload.to_json } }

    before do
      allow_any_instance_of(Webhooks::DropboxSignController).to receive(:api_key).and_return(api_key)
      allow(DropboxSign::Webhooks::SignatureUpdate).to receive(:call).and_return(true)
    end

    context "when the IP is allowed and HMAC is correct" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).
          and_return(Webhooks::DropboxSignController::ALLOWED_IPS.sample)
      end

      it "creates a new event" do
        expect { subject }.to change(InboundWebhook, :count).by(1)
      end

      it "returns an HTTP status of ok" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the IP is not allowed" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).
          and_return("192.168.1.1")
      end

      it "returns a not found response" do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the HMAC is incorrect" do
      # invalid HMAC
      let(:mock_event_hash) do
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), api_key, event_type)
      end
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).
          and_return(Webhooks::DropboxSignController::ALLOWED_IPS.sample)
      end

      it "returns a not found response" do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
