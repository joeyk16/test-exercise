class Product < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :category

  has_many :product_sizes
  has_many :product_images, :dependent => :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :category, :user, :price, presence: true

  accepts_nested_attributes_for :product_images, allow_destroy: true
end
