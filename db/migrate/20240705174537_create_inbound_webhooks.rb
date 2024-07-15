class CreateInboundWebhooks < ActiveRecord::Migration[7.1]
  def change
    create_table :inbound_webhooks do |t|
      t.jsonb :body
      t.string :status

      t.timestamps
    end
  end
end
