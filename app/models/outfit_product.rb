class OutfitProduct < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :product
  belongs_to :user
end
