class Product < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :category

  has_many :outfit_products
  has_many :outfits, through: :outfit_products

  has_many :product_sizes
  has_many :product_images, :dependent => :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :category, :user, :price, presence: true

  accepts_nested_attributes_for :product_images, :product_sizes, allow_destroy: true

  has_attached_file :image, styles: { large: "600x600", medium: "250x250", thumb:"100x100#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
