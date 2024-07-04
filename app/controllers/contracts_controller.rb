# frozen_string_literal: true

class ContractsController < ApplicationController
  def show
    @contract = Users::Contract.find_or_create_by(user: current_user)
    generate_pdf unless @contract.document.attached?
    respond_to do |format|
      format.html
      format.pdf do
        send_data @contract.document.download, filename: "file.pdf"
      end
    end
  end

  def create
    DropboxSign::SignatureRequest.new(
      file_urls: [current_user.contract.document.blob.url],
      signers: [{name: "Francois DevTech", email: "francois.devtech@gmail.com"}],
      metadata: { kind: "contract" },
      options: {
        title: "mon titre",
        subject: "mon sujet",
        message: "mon message"
      }
    ).call
    redirect_to contract_path
  end

  private

  def generate_pdf
    pdf = ::PdfGenerator::Base.generate_now(template: "contracts/_contract", locals: {})
    @contract.document.attach(
      io: StringIO.new(pdf), filename: "contract", content_type: "application/pdf"
    )
  end
end
