require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:user2) { create(:user, admin: false) }
  let!(:product) { create(:product, user_id: user.id) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:products) do
    [product] + 3.times.map { create(:product) }
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
      get :new, {}, { user_id: user.id }
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "visitor redirected to root_url" do
      get :new
      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST #create" do
    it "as user" do
      post :create, { product: product_params }, { user_id: user.id }
      expect(assigns(:product).errors).to be_empty
    end
  end

  describe "GET #edit" do
    it "as user" do
      get :edit, { id: product.id }, { user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #update" do
    it "as user" do
      patch :update, { id: product.id, product: product_params }, { user_id: user.id }
      expect(response).to redirect_to(assigns(:product))
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "DELETE #destroy" do
    it "as user" do
      delete :destroy, { id: product.id }, { user_id: user.id }
      expect(response).to redirect_to(user_products_path)
    end

    it "as unauthorised user" do
      delete :destroy, { id: product.id }, { user_id: user2.id }
      expect(response).to redirect_to(root_path)
    end
  end
end