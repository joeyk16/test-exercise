class RemoveSizesIdsFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :size_ids, :integer
  end
end
