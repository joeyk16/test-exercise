require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:product) }
    it { is_expected.to validate_presence_of(:outfit) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:shipping_method) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:outfit) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:size) }
    it { is_expected.to belong_to(:shipping_method) }
  end
end
