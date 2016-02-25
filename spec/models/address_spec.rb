require 'rails_helper'

RSpec.describe Address, type: :model do
  let!(:address) { create(:address) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:address_line_1) }
    it { is_expected.to validate_presence_of(:suburb) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:postcode) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  context "full address" do
    before { address.user }
    it { expect(address.address_to_s).to eq(
      "#{address.address_line_1}, #{address.suburb}, #{address.state}, #{address.country}, #{address.postcode}"
      )
    }
  end
end
