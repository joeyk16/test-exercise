class Size < ActiveRecord::Base
	validates :title, :category, presence: true, length: { maximum: 15 }

  belongs_to :category

  delegate :to_s, to: :title
end
