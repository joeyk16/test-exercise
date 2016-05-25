require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:orders) do
    create_list(:order, 5, user: user)
  end

  let(:order) { orders[0] }

  let(:order_params) { order.attributes }

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
      expect(order.shipping_code).to be_nil
    end

    context "vistor redirects to login path" do
      before { get :create, { user_id: user}, {} }
      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end
end
