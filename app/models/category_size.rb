class CategorySize < ActiveRecord::Base
  belongs_to :category
  belongs_to :size
end
