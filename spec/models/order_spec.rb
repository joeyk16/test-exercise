require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { create(:order) }
  let(:shipping_method) { order.shipping_method }
  let(:product) { order.product }
  let(:product_size) { order.product.product_sizes.find_by(size_id: order.size_id) }

  before do
    order.update_attributes(product_price_in_cents: 1000)
    order.update_attributes(shipping_price_in_cents: 1000)
    product_size.update_attributes(quantity: 10)
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:outfit_user_id) }
    it { is_expected.to validate_presence_of(:product_id) }
    it { is_expected.to validate_presence_of(:product_user_id) }
    it { is_expected.to validate_presence_of(:product_name) }
    it { is_expected.to validate_presence_of(:product_price_in_cents) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:shipping_price_in_cents) }
    it { is_expected.to validate_presence_of(:shipping_method) }
    it { is_expected.to validate_presence_of(:shipping_address) }
    it { is_expected.to validate_presence_of(:aasm_state) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  describe "#total_price" do
    it { expect(order.total_price).to eq(20.00) }
  end

  describe "#drop_product_quantity!" do
    before do
     order.drop_product_quantity!
     product_size.reload
    end

    it { expect(product_size.quantity).to eq(9) }
  end

  describe "#user_owns_outfit?" do
    context "false" do
      it { expect(order.user_owns_outfit?).to eq(false) }
    end
  end

  describe "Self" do
    let!(:user) { create(:user, admin: false) }
    let!(:product) { create(:product) }
    let!(:outfit) { create(:outfit, user: user) }
    let!(:cart_item) do
      create(:cart_item, quantity: 1,
                         product: product,
                         size_id: product.sizes[0].id,
                         user: user,
                         outfit: outfit)
    end
    let(:user_order) { user.orders.where(product_id: product.id).first }

    context "#process_cart_items!" do
      before do
        Order.process_cart_items!(user)
      end

      it  do
        expect(user_order).to be_valid
        expect(user_order.product_id).to eq(product.id)
        expect(user_order.user_id).to eq(user.id)
        expect(user_order.outfit_user_id).to eq(outfit.user.id)
      end
    end
  end
end
