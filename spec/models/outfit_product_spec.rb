require 'rails_helper'

RSpec.describe OutfitProduct, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:outfit) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:user) }
  end
end
