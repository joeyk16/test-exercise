require 'rails_helper'

RSpec.describe Outfit, type: :model do
  describe "validations" do
    it { is_expected.to validate_length_of(:caption).is_at_most(45) }
    it { is_expected.to validate_presence_of(:caption) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:outfit_products) }
    it { is_expected.to have_many(:approved_outfit_products) }
    it { is_expected.to have_many(:approved_products) }

    it { is_expected.to have_many(:approved_products) }
  end
end
