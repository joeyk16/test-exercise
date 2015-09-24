class Category < ActiveRecord::Base
  has_ancestry
  has_many :items
  validates :name, presence: true, length: { maximum: 20 }
  has_many :category_sizes
  has_many :sizes, through: :category_sizes
end