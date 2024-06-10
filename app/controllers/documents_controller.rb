# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ::PdfGenerator::Base.generate_now(template: "documents/_table", locals:{})
        send_data pdf, filename: "file.pdf"
      end
    end
  end
end
