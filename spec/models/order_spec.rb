require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:outfit_user_id) }
    it { is_expected.to validate_presence_of(:product_id) }
    it { is_expected.to validate_presence_of(:product_user_id) }
    it { is_expected.to validate_presence_of(:product_name) }
    it { is_expected.to validate_presence_of(:product_price_in_cents) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:shipping_price_in_cents) }
    it { is_expected.to validate_presence_of(:shipping_method) }
    it { is_expected.to validate_presence_of(:shipping_address) }
    it { is_expected.to validate_presence_of(:aasm_state) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end
end
