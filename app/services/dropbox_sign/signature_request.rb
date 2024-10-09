# frozen_string_literal: true

module DropboxSign
  class SignatureRequest
    def initialize(file_urls:, signers:, metadata:, options: {})
      @file_urls = file_urls
      @signers = signers
      @metadata = metadata
      @title = options[:title] || "Mon titre"
      @subject = options[:subject] || "Mon sujet"
      @message = options[:message] || "Mon message"
      @embed = options[:embed] || false
      @signature_request_api = Dropbox::Sign::SignatureRequestApi.new
    end

    def call # rubocop:disable Metrics/MethodLength
      dropbox_object = Dropbox::Sign::SignatureRequestSendRequest.new

      build_options(dropbox_object)
      dropbox_object.file_urls = @file_urls
      dropbox_object.signers = signers

      if @embed
        @signature_request_api.signature_request_create_embedded(dropbox_object)
      else
        @signature_request_api.signature_request_send(dropbox_object)
      end
    rescue Dropbox::Sign::ApiError => e
      Rails.logger.error("Exception when calling Dropbox Sign API: : #{e.message}")
    end

    private

    # [{name: "Francois DevTech", email: francois.devtech@gmail.com}]
    def signers
      signers = []
      @signers.each_with_index do |signer, index|
        order = (index + 1).to_s
        dropbox_signer = Dropbox::Sign::SubSignatureRequestSigner.new
        dropbox_signer.email_address = signer[:email]
        dropbox_signer.name = signer[:name]
        dropbox_signer.order = order
        signers << dropbox_signer
      end

      signers
    end

    def build_options(dropbox_object)
      dropbox_object.title = @title
      dropbox_object.subject = @subject
      dropbox_object.message = @message
      dropbox_object.metadata = @metadata
      dropbox_object.test_mode = true
      dropbox_object.signing_options = build_signing_options
      dropbox_object.use_text_tags = text_tag?
      dropbox_object.client_id = Rails.application.credentials.hellosign_client_key if @embed
    end

    def text_tag?
      @metadata[:kind] == "contract"
    end

    def build_signing_options
      signing_options = Dropbox::Sign::SubSigningOptions.new
      signing_options.draw = true
      signing_options.type = true
      signing_options.upload = true
      signing_options.phone = true
      signing_options.default_type = "draw"

      signing_options
    end
  end
end
