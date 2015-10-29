class CreateOutfitProducts < ActiveRecord::Migration
  def change
    create_table :outfit_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :outfit, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :outfit_similar_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :outfit, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
