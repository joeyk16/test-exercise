require 'rails_helper'

RSpec.describe ProductSize, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:size) }
  end
end
