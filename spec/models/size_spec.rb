require 'rails_helper'
RSpec.describe Size, type: :model do
	let!(:size) { create(:size) }
	let!(:category) { create(:category) }

	describe "validations" do
		it { is_expected.to validate_uniqueness_of(:title) }
		it { is_expected.to validate_length_of(:title).is_at_most(15) }
		it { is_expected.to validate_presence_of(:title) }
	end

	describe "associations" do
		it { is_expected.to belong_to(:category) }
	end

	describe "have a matching title" do
		before { size.title = "title01"}
		it { expect(size.title).to eq("title01") }
	end

	describe "valid with title" do
		before { size.title = "title01"}
		it { expect(size).to be_valid }
	end

	describe "invalid no title" do
		before { size.title = nil }
		it { expect(size).to be_invalid }
	end
end
