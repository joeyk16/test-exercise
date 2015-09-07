class Category < ActiveRecord::Base
	has_ancestry
	has_many :items
	validates :name, presence: true, length: { maximum: 20 }
end
