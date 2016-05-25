class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  has_many :outfits
  has_many :outfit_products
  has_many :addresses
  has_many :shipping_methods
  has_many :relationships
  has_many :cart_items
  has_many :paypals
  has_many :orders

  has_attached_file :avatar, styles: { large: "250x250", medium:"100x100", small:"50x50", thumb:"30x30#"}
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_attached_file :header_image, styles: { large: "1170x266" }
  validates_attachment_content_type :header_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
