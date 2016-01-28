require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:username).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:outfits) }
    it { is_expected.to have_many(:outfit_products) }
  end
end
