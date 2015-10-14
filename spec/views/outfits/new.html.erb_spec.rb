require 'rails_helper'

RSpec.describe "outfits/new", type: :view do
  before(:each) do
    assign(:outfit, Outfit.new(
      :description => "MyText"
    ))
  end

  it "renders new outfit form" do
    render

    assert_select "form[action=?][method=?]", outfits_path, "post" do

      assert_select "textarea#outfit_description[name=?]", "outfit[description]"
    end
  end
end
