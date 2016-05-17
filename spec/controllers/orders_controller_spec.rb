require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:orders) do
    create_list(:order, 5, user: user)
  end

  describe "GET #index" do
    #This order shouldnt be in the list
    let!(:order) { create(:order) }

    it "user renders index template" do
      sign_in(user)
      get :index,{ user_id: user }, {}

      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
      expect(assigns(:orders)).to eq(orders.reverse)
      expect(assigns(:orders).count).to eq(5)
      expect(Order.count).to eq(6)
    end

    it "vistor redirects to login path" do
      get :index, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
