class Relationship < ActiveRecord::Base
  belongs_to :user

  def self.followers(user)
    Relationship.where(following_id: user)
  end
end
