require "rails_helper"

RSpec.describe ItemsController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:user2) { create(:user, admin: false) }
  let!(:item) { create(:item, user_id: user.id) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:items) do
    [item] + 3.times.map { create(:item) }
  end

  let!(:item_params) { item_params = build(:item).attributes }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  describe "GET #index" do
    it "renders template and shows items" do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:items)).to eq(items)
    end
  end

  describe "GET #show" do
    it "renders template and shows items" do
      get :show, id: item.id
      expect(response).to render_template(:show)
      expect(assigns(:item)).to eq(item)
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
      post :create, { item: item_params }, { user_id: user.id }
      expect(assigns(:item).errors).to be_empty
    end
  end

  describe "GET #edit" do
    it "as user" do
      get :edit, { id: item.id }, { user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST #update" do
    it "as user" do
      patch :update, { id: item.id, item: item_params }, { user_id: user.id }
      expect(response).to redirect_to(assigns(:item))
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "DELETE #destroy" do
    it "as user" do
      delete :destroy, { id: item.id }, { user_id: user.id }
      expect(response).to redirect_to(user_items_path)
    end

    it "as unauthorised user" do
      delete :destroy, { id: item.id }, { user_id: user2.id }
      expect(response).to redirect_to(root_path)
    end
  end
end