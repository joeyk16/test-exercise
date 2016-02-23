class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  has_many :outfits
  has_many :outfit_products
  has_many :addresses
  has_many :shipping_methods
  has_many :carts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, length: { maximum: 50, minimum: 5 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_attached_file :avatar, styles: { large: "250x250", medium:"100x100", small:"50x50", thumb:"30x30#"}
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_attached_file :header_image, styles: { large: "1170x266" }
  validates_attachment_content_type :header_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
