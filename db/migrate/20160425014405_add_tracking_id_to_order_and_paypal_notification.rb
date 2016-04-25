class AddTrackingIdToOrderAndPaypalNotification < ActiveRecord::Migration
  def change
    add_column :orders, :tracking_id, :integer
    remove_column :orders, :invoice_id, :integer
  end
end
