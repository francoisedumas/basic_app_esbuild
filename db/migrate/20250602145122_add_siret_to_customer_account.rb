class AddSiretToCustomerAccount < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_accounts, :siret, :string
  end
end
