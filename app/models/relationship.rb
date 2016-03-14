class Relationship < ActiveRecord::Base
  belongs_to :user
  before_save  :unique

  def self.followers(user)
    Relationship.where(following_id: user)
  end

  def self.following(user)
    Relationship.where(user: user)
  end

  def unique
    return true unless Relationship.find_by(
      following_id: following_id,
      user_id: user_id
      )
  end
end
