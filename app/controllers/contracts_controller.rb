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

  def edit
    @contract = Users::Contract.find_or_create_by(user: current_user)

    if (signature_id = signer_signature_id)
      result = Dropbox::Sign::EmbeddedApi.new.embedded_sign_url(signature_id)
      @sign_url = result.embedded.sign_url
    else
      flash[:alert] = "Une erreur est survenue avec la signature éléctronique"
      redirect_to contract_path
    end
  end

  def create
    response = DropboxSign::SignatureRequest.new(
      file_urls: [current_user.contract.document.blob.url],
      signers: [{ name: "Francois DevTech", email: "francois.devtech@gmail.com" }],
      metadata: { kind: "contract" },
      options: {
        title: "mon titre",
        subject: "mon sujet",
        message: "mon message",
        embed: true
      }
    ).call
    signature = response.signature_request.signature_request_id
    current_user.contract.update(dropbox_sign_signature_request_id: signature)
    flash[:notice] = "C'est envoyé!"
    redirect_to edit_contract_path
  end

  private

  def signer_signature_id
    result = Dropbox::Sign::SignatureRequestApi.new.signature_request_get(@contract.dropbox_sign_signature_request_id)
    result.signature_request.signatures.first.signature_id
  end

  def generate_pdf
    pdf = ::PdfGenerator::Base.generate_now(template: "contracts/_contract", locals: {})
    @contract.document.attach(
      io: StringIO.new(pdf), filename: "contract", content_type: "application/pdf"
    )
  end
end
