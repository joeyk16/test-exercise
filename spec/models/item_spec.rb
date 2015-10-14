require 'rails_helper'
RSpec.describe Item, type: :model do


  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:title) }

    it { is_expected.to validate_length_of(:title).is_at_most(30) }
    it { is_expected.to validate_length_of(:description).is_at_most(2000) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end
end