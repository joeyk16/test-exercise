class CreateShippingMethod < ActiveRecord::Migration
  def change
    create_table :shipping_methods do |t|
      t.string :name
      t.references :user, index: true
      t.integer :price
      t.string :country
    end
    add_foreign_key :shipping_methods, :users
  end
end
