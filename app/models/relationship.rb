class Relationship < ActiveRecord::Base
  belongs_to :user
  before_save :unique_relationship

  def self.followers(user)
    Relationship.where(following_id: user)
  end

  def unique_relationship

  end
end
