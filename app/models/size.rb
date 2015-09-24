class Size < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 15 }
	validates :title, uniqueness: true

  has_many :category_sizes
  has_many :categories, through: :category_sizes
end
