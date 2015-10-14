require 'rails_helper'

RSpec.describe "outfits/edit", type: :view do
  before(:each) do
    @outfit = assign(:outfit, Outfit.create!(
      :description => "MyText"
    ))
  end

  it "renders the edit outfit form" do
    render

    assert_select "form[action=?][method=?]", outfit_path(@outfit), "post" do

      assert_select "textarea#outfit_description[name=?]", "outfit[description]"
    end
  end
end
