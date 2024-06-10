# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "super_pdf",
          formats: [:html],
          template: "documents/_table",
          disposition: :attachment,
          layout: "wicked_pdf"
      end
    end
  end
end
