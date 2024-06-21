class CreateCustomerAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :vat_number

      t.timestamps
    end
  end
end
