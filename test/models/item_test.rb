require 'test_helper'

class ItemTest < ActiveSupport::TestCase

	def setup
		@user = users(:michael)
		@item = @user.items.build(title:"iPhone 5c 16gb blue", price:"600.50", description:"The iPhone 5c is not the shy type, flaunting a lively exterior to match your personality, lifestyle, or your friends. A smooth rounded finish gives a real character to this innovative smartphone and is sure to catch the eye of onlookers.")
	end
	
	test "Item should be valid" do
		assert @item.valid?
	end

	test "title should be present" do 
		@item.title = "    "
		assert_not @item.valid?
	end

	test "price should be present" do 
		@item.price = "    "
		assert_not @item.valid?
	end

	test "description should be present" do 
		@item.description = "    "
		assert_not @item.valid?
	end

	test "Title should not be too long" do
		@item.title = "a"*31
		assert_not @item.valid?
	end

	test "Description should not be too long" do
		@item.description = "a"*2001
		assert_not @item.valid?
	end

	test "user id should be present" do
		@item.user_id = nil
		assert_not @item.valid?
	end

end
