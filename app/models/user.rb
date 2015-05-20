class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50, minimum: 5 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }
end
	