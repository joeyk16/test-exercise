class Size < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 15 }
	validates :title, uniqueness: true
end
