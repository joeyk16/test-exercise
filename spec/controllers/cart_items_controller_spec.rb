require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let!(:product) { create(:product) }
  let!(:user) { create(:user, admin: false) }
  let!(:cart_items) do
    create_list(:cart_item, 5, product: product, size_id: product.sizes[0].id, user: user )
  end
  let!(:cart_item) { cart_items[0] }
  let(:cart_item_params) { cart_item.attributes }

  describe "GET #index" do
    #This cart_item is the 6th cart_item that shouldn't be in the list
    let!(:cart_item) { create(:cart_item, product: product, size_id: product.sizes[0].id) }

    it "user renders index template" do
      sign_in(user)
      get :index,{ user_id: user }, {}

      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
      expect(assigns(:cart_items)).to eq(cart_items)
      expect(assigns(:cart_items).count).to eq(5)
      expect(CartItem.count).to eq(6)
    end

    it "vistor redirects to login path" do
      get :index, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    it "user creates cart_item" do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      sign_in(user)
      post :create, { cart_item: cart_item_params, user_id: user }

      expect(response).to redirect_to "where_i_came_from"
      expect(assigns(:cart_item)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { user_id: user }, { }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes cart_item" do
      sign_in(user)
      delete :destroy, { id: cart_item.id, user_id: user.id }

      expect(assigns(:cart_item)).to_not be_persisted
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: cart_item.id, user_id: user.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
