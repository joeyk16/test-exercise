class Address < ActiveRecord::Base
  belongs_to :user

  validates :address_line_1, :suburb, :state, :postcode, :country, presence: true

  def full_address
    "#{address_line_1}, #{suburb}, #{state}, #{country}, #{postcode}"
  end
end
