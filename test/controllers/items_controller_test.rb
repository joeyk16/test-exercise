require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:michael)
    @item = items(:mobile01)
  end

  test "should redirect destroy item for wrong User" do
    log_in_as(users(:michael))
    item = items(:mobile01)
    assert_no_difference 'Item.count' do
      delete :destroy, id: item
    end
    assert_redirected_to root_url
  end

  test "should redirect edit item for wrong user" do
    log_in_as(@user)
    patch :edit, id: @user, item: { title: "Apple iPhone 2", price: "120" }
    assert_redirected_to root_url
  end

end




