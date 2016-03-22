class Like < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user

  validates :user, :outfit, presence: true
end
