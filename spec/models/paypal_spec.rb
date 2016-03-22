require 'rails_helper'

RSpec.describe Paypal, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
