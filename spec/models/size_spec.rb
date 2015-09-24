require 'rails_helper'
RSpec.describe Size, type: :model do
	describe "validations" do
		it { is_expected.to validate_uniqueness_of(:title) }
		it { is_expected.to ensure_length_of(:title).is_at_most(15) }
		it { is_expected.to validate_presence_of(:title) }
	end

	describe "associations" do
		it { is_expected.to belong_to(:category) }
	end

	let(:size01) { FactoryGirl.create :size01 }
	let(:size02) { FactoryGirl.build :size02 }
	let(:size03) { FactoryGirl.create :size03 }
	let(:category) { FactoryGirl.create(:category) }

	it "should have a matching title" do
		expect(size01.title).to eq("XXLarge")
	end

	it "is valid with title" do
		expect(size01).to be_valid
	end

	it "is invalid without a title" do
	  expect(size02).to be_invalid
	end

  it 'should return the name of size' do
  	expect(category.size_id).to eql(1) #1 is the id of size01
  end
end