class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.text :notification
      t.string :tracking_id
      t.string :status

      t.timestamps null: false
    end
  end
end
