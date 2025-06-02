class AddArchiveToCustomerAccount < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_accounts, :archived, :boolean, default: false
  end
end
