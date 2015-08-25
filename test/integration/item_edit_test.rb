require 'test_helper'

class ItemsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @item = items(:mobile01)
  end

  test "successful item edit redirects to edit item" do
  	log_in_as(@user)
    get edit_item_path(@item)
    assert_template "items/edit"
    patch item_path(@item), id: @user, item: { title: "Tile_change",
                                    price: "120",
                                    image_file_name: "Motorola_XT1068_Moto_G2_Black.jpg",
                                    description: "MyText"
                                  }
    assert_template "items/show"
  end                       

end





