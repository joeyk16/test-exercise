class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.text :notification
      t.string :transaction_id
      t.string :status
      t.string :invoice_id

      t.timestamps null: false
    end
  end
end
