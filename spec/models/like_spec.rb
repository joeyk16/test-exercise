require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:outfit) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:outfit) }
    it { is_expected.to belong_to(:user) }
  end
end
