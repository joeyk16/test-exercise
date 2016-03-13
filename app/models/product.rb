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

  accepts_nested_attributes_for :product_images, allow_destroy: true
  accepts_nested_attributes_for :product_sizes,
   allow_destroy: true,
   reject_if: ->(attrs) { attrs[:quantity].to_i.zero? }

  def price
    price_in_cents / 100.00
  end
end
