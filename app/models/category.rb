class Category < ActiveRecord::Base
  has_ancestry

  has_many :products
  has_many :sizes

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true

  accepts_nested_attributes_for :sizes, allow_destroy: true
end
