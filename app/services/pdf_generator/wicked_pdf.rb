# frozen_string_literal: true

module PdfGenerator
  class WickedPdf < Base
    def generate_now
      ::WickedPdf.new.pdf_from_string(html_content)
    end

    private

    def layout
      "wicked_pdf"
    end
  end
end
