require 'rails_helper'
RSpec.describe Size, type: :model do

	it { is_expected.to validate_uniqueness_of(:title) }
	it { should ensure_length_of(:title).is_at_most(15) }
	it { is_expected.to validate_presence_of(:title) }

	let(:size01) { FactoryGirl.create :size01 }
	let(:size02) { FactoryGirl.build :size02 }
	let(:size03) { FactoryGirl.create :size03 }


	it "should have a matching title" do
		expect(size01.title).to eq("XXLarge")
	end

	it "is valid with title" do
		expect(size01).to be_valid
	end

	it "is invalid without a title" do
	  expect(size02).to be_invalid
	end



end
