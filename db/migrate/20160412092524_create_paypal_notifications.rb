class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.text :notification
      t.string :paypal_pay_key
      t.string :status

      t.timestamps null: false
    end
  end
end
