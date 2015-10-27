class Category < ActiveRecord::Base
  has_ancestry

  has_many :products
  has_many :category_sizes
  has_many :sizes, through: :category_sizes

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
end