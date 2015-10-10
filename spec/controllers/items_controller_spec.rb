require "rails_helper"

RSpec.describe ItemsController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:item) { create(:item, user_id: user.id) }

  let!(:items) do
    3.times.map { create(:item) }
  end

  let!(:item_params) { item_params = item.attributes }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  # describe "GET #index" do
  #   it "renders template and shows items" do
  #     get :index
  #     expect(response).to render_template(:index)
  #     expect(assigns(:items)).to eq(items)
  #   end
  # end

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

    it "visitor renders redirected to root_url" do
      get :new
      expect(response).to redirect_to(login_path)
    end
  end

  # describe "POST #create" do
  #   it "user created" do
  #     post :create, current_user: user, item: item_params
  #     expect(assigns(:item)).to be_persisted
  #   end
  # end

  describe "GET #edit" do
    it "user edit" do
      get :edit, { id: item.id }, { user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST #update" do
    it "user updated" do
      patch :update, { id: item.id }, { user_id: user.id }, item: item_params
      expect(response).to redirect_to(assigns(:item))
      expect(assigns(:item)).to eq(item)
    end
  end

  # describe "DELETE #destroy" do
  #   it "user destroy" do
  #     delete :destroy, {id: user.id }, { user_id: user.id }, user: user_params
  #     expect(response).to redirect_to(users_path)
  #   end
  # end
end