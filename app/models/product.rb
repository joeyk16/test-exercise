class Product < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :category

  has_many :outfit_products
  has_many :outfits, through: :outfit_products
  has_many :product_sizes
  has_many :cart_items, dependent: :destroy
  has_many :product_images, dependent: :destroy

  def sizes
    size_ids = product_sizes.map{ |ps| ps.size_id }
    Size.where(id: size_ids)
  end

  def self.enough_quantity?(cart_item)
    product_size = cart_item.product.product_sizes.find_by(size_id: cart_item.size_id)
    product_size.quantity >= cart_item.quantity
  end

  def self.adjust_quantity!(cart_item)
    product_size = cart_item.product.product_sizes.find_by(size_id: cart_item.size_id)
    quantity = cart_item.quantity
    if product_size.quantity >= quantity
      product_size.quantity -= quantity
    else
      errors.add(:base, "Product doesn't have enough quantity")
    end
  end
end
