require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:following_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
