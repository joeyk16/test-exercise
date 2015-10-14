require 'rails_helper'

RSpec.describe "outfits/show", type: :view do
  before(:each) do
    @outfit = assign(:outfit, Outfit.create!(
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
