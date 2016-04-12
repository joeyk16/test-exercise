class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.references :order, index: true
      t.text :notification
      t.string :transaction_id
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :paypal_notifications, :orders
  end
end
