class AddPaypalPayKeyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paypal_pay_key, :string
  end
end
