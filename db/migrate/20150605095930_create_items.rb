class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.decimal :price
      t.text :description

      t.timestamps null: false
    end
  end
end
