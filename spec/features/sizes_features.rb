require "rails_helper"
RSpec.feature "adding size" do 

	let(:size01) { FactoryGirl.build :size01 }
	let(:user) { FactoryGirl.build :user }
	let!(:admin) { FactoryGirl.create(:user, admin: true) }

	scenario "allow a admin user to add a size" do
		admin = create(:admin)
		log_in(:admin)
		visit new_size_path
		fill_in 'Title', with: "example"
		click_button 'Create Size'
		expect(current_path).to eql(sizes_path)
		expect(page).to have_content("example")
	end

	scenario "user can't add size" do
		log_in(user)
		visit sizes_path	
		expect(current_path).to eql(root_path)
		expect(page).to have_content("Rescricted Web Page")
	end

	scenario "vistor can't add size" do
		visit sizes_path	
		expect(current_path).to eql(root_path)
	end

end
