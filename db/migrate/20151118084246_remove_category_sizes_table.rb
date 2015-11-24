class RemoveCategorySizesTable < ActiveRecord::Migration
  def up
    drop_table :category_sizes
  end
end