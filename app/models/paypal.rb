class Paypal < ActiveRecord::Base
  belongs_to :user

  validates :email, presence: true

  before_save :user_has_one_default_paypal_account

  def user_has_one_default_paypal_account
    return unless self.default == true
    return unless paypal = user.paypals.find_by(default: true)
    return if paypal.id == self.id
    paypal.update_attributes(default: false)
  end
end
