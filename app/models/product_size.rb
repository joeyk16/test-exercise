class ProductSize < ActiveRecord::Base
  belongs_to :product
  belongs_to :size

  validates :quantity, presence: true
end
