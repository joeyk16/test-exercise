require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:other_user) { create(:user, admin: false) }
  let!(:other_user) { create(:user, admin: false) }
  let!(:paypal) { create(:paypal, user: user) }
  let!(:paypal2) { create(:paypal, user: other_user) }
  let!(:product) { create(:product, user_id: user.id) }
  let!(:product_02) { create(:product, user_id: other_user.id) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:products) do
    [product, product_02] + 3.times.map { create(:product) }
  end

  let!(:product_params) { product_params = build(:product).attributes }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  describe "GET #index" do
    it "renders template and shows products" do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:products)).to eq(products)
    end
  end

  describe "GET #show" do
    it "renders template and shows products" do
      get :show, id: product.id
      expect(response).to render_template(:show)
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #new" do
    it "renders template" do
      sign_in(user)
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "visitor redirected to root_url" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user with no paypal acocunt redirected to user" do
      other_user.paypals.destroy_all
      sign_in(other_user)
      get :new

      expect(response).to redirect_to(new_user_paypal_path(other_user))
    end
  end

  describe "POST #create" do
    it "as user" do
      sign_in(user)
      post :create, { product: product_params }
      expect(assigns(:product).errors).to be_empty
    end

    it "redirects visitor" do
      post :create, { product: product_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user with no paypal acocunt redirected to user" do
      other_user.paypals.destroy_all
      sign_in(other_user)
      post :create, { product: product_params }

      expect(response).to redirect_to(new_user_paypal_path(other_user))
    end
  end

  describe "GET #edit" do
    it "as user" do
      sign_in(user)
      get :edit, { id: product.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:product)).to eq(product)
    end

    it "user you can't edit another users product" do
      sign_in(other_user)
      get :edit, { id: product.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      get :edit, { id: product.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user with no paypal acocunt redirected to user" do
      other_user.paypals.destroy_all
      sign_in(other_user)
      get :edit, { id: product.id }

      expect(response).to redirect_to(new_user_paypal_path(other_user))
    end
  end

  describe "POST #update" do
    it "as user" do
      sign_in(user)
      patch :update, { id: product.id, product: product_params }
      expect(response).to redirect_to(assigns(:product))
      expect(assigns(:product)).to eq(product)
    end

    it "redirects visitor" do
      patch :update, { id: product.id, product: product_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user can't update another user's product" do
      sign_in(other_user)
      patch :update, { id: product.id, product: product_params }
      expect(response).to redirect_to(root_path)
    end

    it "user with no paypal acocunt redirected to user" do
      other_user.paypals.destroy_all
      sign_in(other_user)
      patch :update, { id: product.id, product: product_params }

      expect(response).to redirect_to(new_user_paypal_path(other_user))
    end
  end

  describe "DELETE #destroy" do
    it "as user" do
      product_count = Product.all.count
      sign_in(user)
      delete :destroy, { id: product.id }
      expect(Product.all.count).to eq(product_count - 1)
      expect(response).to redirect_to(user_products_path)
    end

    it "user you can't delete another users product" do
      sign_in(other_user)
      delete :destroy, { id: product.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      delete :destroy, { id: product.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "as unauthorised user" do
      delete :destroy, { id: product.id }, { user_id: other_user.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
