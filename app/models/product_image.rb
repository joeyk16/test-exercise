class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :product_image, styles: { large: "600x600", medium: "250x250", thumb:"100x100#"}
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\Z/
end
