class Outfit < ActiveRecord::Base
  belongs_to :user
  has_many :outfit_products
  has_many :products, through: :outfit_products
  has_many :approved_outfit_products, -> { where(approved: true) },
           class_name: 'OutfitProduct'
  has_many :approved_products, through: :approved_outfit_products,
           class_name: 'Product'
  has_many :approved_products, through: :approved_outfit_products, source: :product

  validates :caption, presence: true, length: { maximum: 45}

  acts_as_taggable

  has_attached_file :outfit_image, styles: { large: "250x250", thumb:"30x30#"}
  validates_attachment_content_type :outfit_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
