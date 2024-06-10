# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data(
          pdf,
          disposition: :attachment,
          filename: "top_pdf",
          type: "application/pdf"
        )
      end
    end
  end

  private

  def pdf
    html_string = render_to_string(
      partial: "documents/table",
      layout: "grover",
      formats: [:html],
      locals: { tailwind_css: }
    )
    Grover.new(html_string, display_ulr: "http://localhost:3000").to_pdf
  end

  def tailwind_css
    file_paths = Dir.glob(Rails.root.join("public", "assets", "application-*.css"))
    latest = file_paths.max_by { |p| File.mtime(p) }
    File.read latest
  end
end
