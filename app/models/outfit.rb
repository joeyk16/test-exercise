class Outfit < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  has_attached_file :outfit_image, styles: { large: "250x250", thumb:"30x30#"}
  validates_attachment_content_type :outfit_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
