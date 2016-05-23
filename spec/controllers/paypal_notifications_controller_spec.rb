require 'rails_helper'

RSpec.describe PaypalNotificationsController, type: :controller do
  let!(:order) { create(:order, tracking_code: "abcdefg") }

  def create_paypal_notification
    post :create, params
    order.reload
  end

  describe "POST #create" do
    context "order payment is complete" do
      let(:params) { { txn_id: "abcdefg", payment_status: "Completed" } }
      let!(:product_size) { ProductSize.find_by(size_id: order.size_id, product_id: order.product.id) }
      let!(:quantity) { product_size.quantity }


      before do
        create_paypal_notification
        product_size.reload
      end

      it { expect(order.aasm_state).to eq("processing") }
      it { expect(product_size.quantity).to eq(quantity - 1) }
    end

    context "order payment is not complete" do
      let(:params) { { txn_id: "abcdefg", payment_status: "nul" } }

      before do
        create_paypal_notification
      end

      it { expect(order.aasm_state).to eq("pending_payment") }
    end
  end
end
