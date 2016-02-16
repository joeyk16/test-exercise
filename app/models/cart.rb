class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
end
