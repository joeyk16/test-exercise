require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:orders) do
    create_list(:order, 5, user: user)
  end

  let(:order) { orders[0] }

  let(:order_params) { order.attributes }

  describe "GET #index" do
    #This order shouldnt be in the list
    let!(:order) { create(:order) }

    it "user renders index template" do
      sign_in(user)
      get :index, { user_id: user }, {}

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

  describe "GET #show" do
    it "user renders show template" do
      sign_in(user)
      get :show, { id: order.id, user_id: user }, {}

      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
      expect(assigns(:order)).to eq(order)
    end

    it "vistor redirects to login path" do
      get :show, { id: order.id, user_id: user }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #create" do
    let!(:product_01) { create(:product) }
    let!(:product_02) { create(:product) }
    let!(:outfit) { create(:outfit, user: user) }
    let!(:cart_item_01) do
      create(:cart_item, quantity: 1, product: product_01,
                         size_id: product_01.sizes[0].id, user: user)
    end
    let!(:cart_item_02) do
      create(:cart_item, quantity: 1, product: product_02,
                         size_id: product_02.sizes[0].id, user: user)
    end
    let(:order) { user.orders.where(product_id: product_01.id).first }

    it "2 orders created" do
      user.orders.destroy_all
      sign_in(user)
      post :create, { user_id: user}, {}

      expect(user.orders.count).to eq(2)
      expect(order.aasm_state).to eq("pending_payment")
      expect(order.user).to eq(user)
      expect(order.product).to eq(product_01)
      expect(order.product_name).to eq(product_01.title)
      expect(order.product_price_in_cents).to eq(product_01.price_in_cents)
      expect(order.quantity).to eq(1)
      expect(order.tracking_code).to_not be_nil
      expect(order.product_user_id).to eq(product_01.user.id)
      expect(order.shipping_code).to be_nil
    end

    context "vistor redirects to login path" do
      before { get :create, { user_id: user}, {} }
      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  describe "GET #edit" do
    it "user renders show template" do
      sign_in(user)
      get :edit, { id: order.id, user_id: user }, {}

      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:order)).to eq(order)
    end

    it "vistor redirects to login path" do
      get :edit, { id: order.id, user_id: user }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #update" do
    before do
      order_params[:shipping_code] = "123abc"
    end

    it "user renders show template" do
      sign_in(user)
      get :update, { id: order.id, user_id: user, order: order_params }, {}

      expect(assigns(:order)).to eq(order)
      expect(assigns(:order).shipping_code).to eq("123abc")
      expect(response).to redirect_to(user_orders_path(user))
    end

    it "vistor redirects to login path" do
      get :update, { id: order.id, user_id: user, order: order_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
