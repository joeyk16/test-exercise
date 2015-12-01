class ProductSize < ActiveRecord::Base
  belongs_to :user
  belongs_to :size

  validates :quantity, presence: true
end
