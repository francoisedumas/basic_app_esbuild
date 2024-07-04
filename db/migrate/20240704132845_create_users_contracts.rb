class CreateUsersContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_contracts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
