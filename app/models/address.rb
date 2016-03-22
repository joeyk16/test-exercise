class Address < ActiveRecord::Base
  belongs_to :user

  validates :address_line_1, :suburb, :state, :postcode, :country, :user, presence: true

  before_save :user_has_one_default_devlivery_address
  before_save :user_has_one_default_billing_address

  def address_to_s
    "#{address_line_1}, #{suburb}, #{state}, #{country}, #{postcode}"
  end

  def user_has_one_default_devlivery_address
    return unless self.default_devlivery_address == true
    return unless address = user.addresses.find_by(default_devlivery_address: true)
    return if address.id == self.id
    address.update_attributes(default_devlivery_address: false)
  end

  def user_has_one_default_billing_address
    return unless self.default_billing_address == true
    return unless address = user.addresses.find_by(default_billing_address: true)
    return if address.id == self.id
    address.update_attributes(default_billing_address: false)
  end
end
