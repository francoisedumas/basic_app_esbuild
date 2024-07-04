# frozen_string_literal: true

class ContractsController < ApplicationController
  def show
    generate_contract_pdf unless current_user.contract.attached?
    respond_to do |format|
      format.html
      format.pdf do
        send_data current_user.contract.download, filename: "file.pdf"
      end
    end
  end

  private

  def generate_contract_pdf
    pdf = ::PdfGenerator::Base.generate_now(template: "contracts/_contract", locals: {})
    current_user.contract.attach(
      io: StringIO.new(pdf), filename: "contract", content_type: "application/pdf"
    )
  end
end
