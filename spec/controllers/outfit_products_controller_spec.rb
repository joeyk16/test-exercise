require "rails_helper"
require "test_helper"

RSpec.describe OutfitProductsController, type: :controller do
  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  let!(:user) { create(:user, admin: false) }
  let!(:other_user) { create(:user, admin: false) }

  let!(:outfit) { create(:outfit) }
  let!(:other_outfit) { create(:outfit, user_id: other_user.id) }

  let(:product) { create(:product, user_id: user.id) }
  let(:other_product) { create(:product, user_id: other_user.id) }

  let(:oufit_product_saved) do
    create(:outfit_product,
      user_id: user.id,
      product_id: product.id,
      outfit_id: outfit.id
    )
  end

  let(:oufit_product) do
    build(:outfit_product,
      user_id: user.id,
      product_id: product.id,
      outfit_id: outfit.id
    )
  end

  let(:outfit_product_params) do
    build(:outfit_product,
      user_id: other_outfit.user_id,
      product_id: other_product.id,
      outfit_id: other_outfit.id,
      outfit_user_id: other_user.id
    )
  end

  let!(:outfit_products) do
    6.times.map do
      create(:outfit_product,
        product_id: create(:product).id,
        outfit_id: oufit_product_saved.id,
        outfit_user_id: user.id,
        user_id: other_user.id
      )
    end
  end

  describe "POST #create" do
    context "outfit product when it's not your outfit" do
      before do
        sign_in(user)
        post :create, {
          outfit: outfit_product_params,
          user_id: user.id,
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        }
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
        sign_in(other_user)
        post :create, {
          outfit: outfit_product_params,
          user_id: other_user.id,
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"],
          outfit_user_id: outfit_product_params["outfit_user_id"]
        }
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

    context "visitor is unauthorized" do
      before do
        post :create, {
          outfit: outfit_product_params,
          user_id: other_user.id,
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        }
      end

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "outfit product deletes" do
      before do
        sign_in(user)
        request.env["HTTP_REFERER"] = "where_i_came_from"
        delete :destroy, {
          id: oufit_product_saved.id,
          user_id: user.id,
          outfit_id: outfit.id,
        }
      end

      it "outfit product is destroyed" do
        expect(assigns(:outfit_product)).to_not be_persisted
      end
    end

    context "visitor is unauthorized" do
      before do
        request.env["HTTP_REFERER"] = "where_i_came_from"
        delete :destroy, {
          id: oufit_product_saved.id,
          user_id: user.id,
          outfit_id: outfit.id,
        }
      end

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Outfit Product exists" do
    context "add product to outfit" do
      before do
        sign_in(user)
        post :create, {
          outfit: oufit_product.attributes,
          user_id: user.id,
          outfit_id: outfit.id,
          product_id: product.id
        }
      end

      it "product has already been added to outfit" do
        expect(response).to redirect_to(user_outfit_path(id: outfit.id, user_id: user.id))
        expect(flash[:info]).to eq "Product already associated with this outfit"
      end
    end

    context "visitor is unauthorized" do
      before do
        post :create, {
          outfit: oufit_product.attributes,
          user_id: user.id,
          outfit_id: outfit.id,
          product_id: product.id
        }
      end

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Outfit Product can't have more then 6 products" do
    context "add 7 products to outfit" do
      let(:outfit_product_params) {
        build(:outfit_product,
          user_id: user.id,
          product_id: 20,
          outfit_id: oufit_product_saved.id
        )
      }

      before do
        sign_in(user)
        post :create, {
          outfit: outfit_product_params,
          user_id: outfit_product_params["user_id"],
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        }
      end

      it "product has already been added to outfit" do
        expect(response).to redirect_to(user_outfit_path(
          id: outfit_product_params["outfit_id"], user_id: outfit_product_params["user_id"]
        ))
        expect(flash[:danger]).to eq "Outfit has too many products. Limit is 6 per outfit"
      end
    end

    context "visitor is unauthorized" do
      before do
        post :create, {
          outfit: outfit_product_params,
          user_id: outfit_product_params["user_id"],
          outfit_id: outfit_product_params["outfit_id"],
          product_id: outfit_product_params["product_id"]
        }
      end

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Approved status" do
    let(:outfit_product_params) {
      build(:outfit_product,
        user_id: user.id,
        approved: false,
        id: oufit_product_saved.id
      )
    }

    context "update approved status to false" do
      before do
        sign_in(user)
        request.env["HTTP_REFERER"] = "where_i_came_from"
        patch :decline, {
          outfit: outfit_product_params,
          user_id: oufit_product_saved["user_id"],
          id: oufit_product_saved.id
        }
      end

      it "outfit product isn't approved" do
        expect(assigns(:outfit_product).approved.to_s).to eq("false")
        expect(flash[:success]).to eq "Successfully declined product for outfit"
      end
    end


    context "update approved status to true" do
      before do
        sign_in(user)
        outfit_product_params["approved"] = true
        request.env["HTTP_REFERER"] = "where_i_came_from"
        patch :approve, {
          outfit: outfit_product_params,
          user_id: oufit_product_saved["user_id"],
          id: oufit_product_saved.id
        }
      end

      it "outfit product is approved" do
        expect(assigns(:outfit_product).approved.to_s).to eq("true")
        expect(flash[:success]).to eq "Successfully approved product for outfit"
      end
    end

    context "visitor is unauthorized" do
      before do
        outfit_product_params["approved"] = true
        request.env["HTTP_REFERER"] = "where_i_came_from"
        patch :approve, {
          outfit: outfit_product_params,
          user_id: oufit_product_saved["user_id"],
          id: oufit_product_saved.id
        }
      end

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #user_outfit_products" do
    context "outfit products path" do
      before do
        sign_in(user)
          get :users_outfit_products, { user_id: user.id }
        end
      it "has outfit products that belong to user" do
        expect(assigns(:outfit_products)).to eq(outfit_products)
      end
    end
  end
end
