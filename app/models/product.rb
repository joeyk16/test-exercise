class Product < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :category

  has_many :outfit_products
  has_many :outfits, through: :outfit_products
  has_many :product_sizes
  has_many :carts, dependent: :destroy
  has_many :product_images, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :category, :user, :price_in_cents, presence: true

  accepts_nested_attributes_for :product_images, allow_destroy: true
  accepts_nested_attributes_for :product_sizes,
   allow_destroy: true,
   reject_if: ->(attrs) { attrs[:quantity].to_i.zero? }

  def sizes
    size_ids = product_sizes.map{ |ps| ps.size_id }
    Size.where(id: size_ids)
  end

  def product_shipping_methods
    user.shipping_methods
  end

  def price
    price_in_cents / 100.00
  end

  def self.adjust_quantity(product_id, size_id, quantity)
    binding.pry
    product_size = Product.find(product_id).product_sizes.find_by(size_id: size_id)
    product_size.quantity - quantity
    product_size.save
  end
end
