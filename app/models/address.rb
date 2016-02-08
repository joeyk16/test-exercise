class Address < ActiveRecord::Base
  belongs_to :user

  validates :address_line_1, :address_line_2, :suburb, :state, :postcode, :country, presence: true
end
