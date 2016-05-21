require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let!(:product) { create(:product, price_in_cents: 1000) }
  let!(:shipping_method) { create(:shipping_method, price_in_cents: 1000) }
  let!(:cart_item) do
    create(:cart_item, product: product, size_id: product.sizes[0].id, shipping_method: shipping_method)
  end

  describe "validations" do
    context "cart item must have user" do
      before do
        cart_item.user.destroy
        cart_item.reload
      end

      it { expect(cart_item).to_not be_valid }
    end

    context "cart item must have outfit" do
      before do
        cart_item.outfit.destroy
        cart_item.reload
      end

      it { expect(cart_item).to_not be_valid }
    end

    context "cart item must have size" do
      before do
        cart_item.size.destroy
        cart_item.reload
      end

      it { expect(cart_item).to_not be_valid }
    end

    context "cart item must have shipping_method" do
      before do
        cart_item.shipping_method.destroy
        cart_item.reload
      end

      it { expect(cart_item).to_not be_valid }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:outfit) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:size) }
    it { is_expected.to belong_to(:shipping_method) }
  end

  describe "total_price" do
    it { expect(cart_item.total_price(1) ).to eq(20.00) }
  end
end
