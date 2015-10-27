require 'rails_helper'
RSpec.describe Category, type: :model do

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:category_sizes) }
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:sizes) }
  end
end