# frozen_string_literal: true

module PdfGenerator
  class Grover < Base
    def generate_now
      ::Grover.new(
        html_content,
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
      ).to_pdf
    end

    private

    def locals
      @locals.merge({ tailwind_css: })
    end

    def tailwind_css
      latest = if Rails.env.development?
                 Rails.root.glob("app/assets/builds/tailwind.css").first
               else
                 file_paths = Rails.root.glob("public/assets/application-*.css")
                 file_paths.max_by { |p| File.mtime(p) }
               end
      File.read latest
    end

    def layout
      "grover"
    end
  end
end
