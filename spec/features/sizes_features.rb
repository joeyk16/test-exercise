require "rails_helper"
RSpec.feature "adding size" do

	let(:size01) { FactoryGirl.build :size01 }
	let(:user) { FactoryGirl.build :user }
	let(:admin) { FactoryGirl.create(:user, admin: true, password: "Password18" ) }

	def admin_logged_in
	  visit login_path
	  fill_in 'Email', with: admin.email
	  fill_in 'Password', with: admin.password
	  click_button 'Log In'
	end

	 def user_logged_in
	  visit login_path
	  fill_in 'Email', with: user.email
	  fill_in 'Password', with: user.password
	  click_button 'Log In'
	end

	scenario "allow a admin user to add a size" do
    admin_logged_in
		visit new_size_path
		fill_in 'Title', with: 'example'
		click_button('Create Size')
		expect(current_path).to eql(sizes_path)
		expect(page).to have_content("List Of Sizes")
		expect(page).to have_content("You have created a new size")
	end

	scenario "user can't add size" do
		user_logged_in
		visit sizes_path
		expect(current_path).to eql(root_path)
	end

	scenario "vistor can't add size" do
		visit sizes_path
		expect(current_path).to eql(root_path)
	end

end