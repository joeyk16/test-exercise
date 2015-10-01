require 'rails_helper'

RSpec.describe CategorySize, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:size) }
  end
end
