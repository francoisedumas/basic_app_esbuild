class AddDropboxSignSignatureRequestIdToUserContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :user_contracts, :dropbox_sign_signature_request_id, :string
  end
end
