# frozen_string_literal: true

module PdfGenerator
  class Browserless < Base
    def generate_now
      ::Browserless::Client.new(
        html: html_content,
        options: {
          display_header_footer: true,
          headerTemplate: %(<div></div>),
          footer_template: %(
            <div style='border-top: solid 1px #bbb; width: 100%; font-size: 9px;
              padding: 5px 5px 0; color: #bbb; position: relative;'>
              <div style='position: absolute; left: 5px; top: 5px;'>
                <span class='date'></span>
              </div>
              <div style='position: absolute; right: 5px; top: 5px;'>
                <span class='pageNumber'></span>/<span class='totalPages'></span>
              </div>
            </div>
          )
        }
      ).to_pdf
    end

    private

    def layout
      "browserless"
    end
  end
end
