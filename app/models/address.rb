class Address < ActiveRecord::Base
  belongs_to :user

  def address_to_s
    "#{address_line_1}, #{suburb}, #{state}, #{country}, #{postcode}"
  end
end
