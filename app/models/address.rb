class Address < ActiveRecord::Base
  belongs_to :user

  validates :address_line_1, :suburb, :state, :postcode, :country, :user, presence: true

  def address_to_s
    "#{address_line_1}, #{suburb}, #{state}, #{country}, #{postcode}"
  end
end
