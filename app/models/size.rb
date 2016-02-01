class Size < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 15 }
	validates :title, uniqueness: true

  belongs_to :category

  delegate :to_s, to: :title
end
