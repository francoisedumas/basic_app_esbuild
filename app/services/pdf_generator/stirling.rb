# frozen_string_literal: true

module PdfGenerator
  class Stirling < Base
    def generate_now
      http = HTTP
      response = http.post(
        "http://localhost:8080/api/v1/convert/html/pdf", form: {
          fileInput: HTTP::FormData::File.new(htmlfile)
        }
      )
      response.body.to_s
    end

    private

    def htmlfile
      file_path = "tmp/demo.html"
      File.write(file_path, html_content)
      file_path
    end

    def layout
      "stirling"
    end
  end
end
