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
      @signature_request_api = Dropbox::Sign::SignatureRequestApi.new
    end

    def call
      dropbox_object = Dropbox::Sign::SignatureRequestSendRequest.new

      build_options(dropbox_object)
      dropbox_object.file_urls = @file_urls
      dropbox_object.signers = signers

      @signature_request_api.signature_request_send(dropbox_object)
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
