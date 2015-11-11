require 'rails_helper'

RSpec.describe OutfitProductsController, type: :controller do
  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  let!(:user) { create(:user, admin: false) }
  let!(:other_user) { create(:user, admin: false) }

  let!(:outfit) { create(:outfit) }
  let!(:other_outfit) { create(:outfit, user_id: other_user.id) }

  let(:product) { create(:product, user_id: user.id) }
  let(:other_product) { create(:product, user_id: other_user.id) }

  let!(:oufit_product_saved) {
    create(:outfit_product,
      user_id: user.id,
      product_id: product.id,
      outfit_id: outfit.id
    )
  }

  let(:oufit_product) {
    build(:outfit_product,
      user_id: user.id,
      product_id: product.id,
      outfit_id: outfit.id
    )
  }

  let(:outfit_product_params) {
    build(:outfit_product,
      user_id: other_outfit.user_id,
      product_id: other_product.id,
      outfit_id: other_outfit.id
    )
  }

  describe "POST #create" do
    context "outfit product when it's not your outfit" do
      before do
        post :create, {
          outfit: outfit_product_params,
          user_id: user.id,
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        },
        { user_id: user.id }
      end

      it "outfit product saved with approved false status" do
        expect(assigns(:outfit_product)).to be_persisted
        expect(assigns(:outfit_product).approved.to_s).to eq("false")
        expect(response).to redirect_to(user_outfit_path(
          id: outfit_product_params["outfit_id"],
          user_id: outfit_product_params["user_id"]
          )
        )
      end
    end

    context "outfit product when it's your outfit" do
      before do
        post :create, {
          outfit: outfit_product_params,
          user_id: other_user.id,
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        },
        { user_id: other_user.id }
      end

      it "outfit product saved with approved true status" do
        expect(assigns(:outfit_product)).to be_persisted
        expect(assigns(:outfit_product).approved.to_s).to eq("true")
        expect(response).to redirect_to(user_outfit_path(
          id: outfit_product_params["outfit_id"],
          user_id: outfit_product_params["user_id"]
          )
        )
      end
    end
  end

  describe "DELETE #destroy" do
    context "user deletes" do
      before do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        delete :destroy, {
          id: oufit_product_saved.id,
          user_id: user.id,
          outfit_id: outfit.id,
        },
        { user_id: user.id }
      end

      it "outfit product saved with approved status" do
        expect(assigns(:outfit_product)).to_not be_persisted
      end
    end
  end

  describe "Outfit Product exists" do
    context "2 of the same products added to outfit" do
      before do
        post :create, {
          outfit: oufit_product.attributes,
          user_id: user.id,
          outfit_id: outfit.id,
          product_id: product.id
        },
        { user_id: user.id }
      end

      it "Outfit Product not created and shows error" do
        expect(response).to redirect_to(user_outfit_path(id: outfit.id, user_id: user.id))
        expect(flash[:info]).to eq "Product already associated with this outfit"
      end
    end
  end
end
