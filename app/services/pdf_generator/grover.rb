# frozen_string_literal: true

module PdfGenerator
  class Grover < Base
    def generate_now
      ::Grover.new(html_content).to_pdf
    end

    private

    def locals
      @locals.merge({ tailwind_css: })
    end

    def tailwind_css
      file_paths = Rails.root.glob("public/assets/application-*.css")
      latest = file_paths.max_by { |p| File.mtime(p) }
      File.read latest
    end

    def layout
      "grover"
    end
  end
end
