require 'rails_helper'

RSpec.describe "outfits/index", type: :view do
  before(:each) do
    assign(:outfits, [
      Outfit.create!(
        :description => "MyText"
      ),
      Outfit.create!(
        :description => "MyText"
      )
    ])
  end

  it "renders a list of outfits" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
