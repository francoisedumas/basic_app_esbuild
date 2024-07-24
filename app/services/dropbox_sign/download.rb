# frozen_string_literal: true

module DropboxSign
  class Download
    def self.call(resource:)
      new(resource:).call
    end

    def initialize(resource:)
      @resource = resource
      @signature_request_id = @resource.dropbox_sign_signature_request_id
    end

    def call
      result = Dropbox::Sign::SignatureRequestApi.new.signature_request_files_as_file_url(@signature_request_id)

      response = Net::HTTP.get_response(URI.parse(result.file_url))
      if response.is_a?(Net::HTTPSuccess)
        attach_document(response.body)
      else
        log_error("Failed to download file from URL: #{file_url}, Response: #{response.code} #{response.message}")
      end
    rescue Dropbox::Sign::ApiError => e
      log_error("Exception when calling Dropbox Sign API: #{e.message}")
    end

    private

    def attach_document(file_content)
      @resource.document.attach(
        io: StringIO.new(file_content),
        filename: "file_signed",
        content_type: "application/pdf"
      )
      true
    end

    def log_error(message)
      Rails.logger.error(message)
      false
    end
  end
end
