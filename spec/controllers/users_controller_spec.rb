require "rails_helper"
require "test_helper"

RSpec.describe UsersController, type: :controller do
  let!(:admin) { create(:user, password: "Password123", admin: true) }
  let!(:user) { create(:user, password: "Password456", admin: false) }

  let!(:update_params) do
    { id: user.id, user_id: user.id, user: user }
  end

  let!(:users) do
    [admin, user] + 3.times.map { create(:user) }
  end

  let!(:user_params) { user_params = { username: "username#{rand(1000)}",
                                       email: "user#{rand(1000)}@factory.com",
                                       password: "Password123",
                                       password_confirmation: "Password123",
                                       admin: false,
                                       description: "Nihil eligendi ab debitis iure.",
                                      } }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  describe "GET #index" do
    it "admin user renders template and shows users" do
      get :index, {}, { user_id: admin.id }
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
      expect(assigns(:users).map(&:id)).to eq users.map(&:id)
    end

    it "user renders template and shows users" do
      get :index, {}, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it "user renders template and redirects" do
      get :index, {}, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "user renders template and shows user" do
      get :show, id: user.id
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "renders template" do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "user created" do
      post :create, user: user_params
      expect(assigns(:user)).to be_persisted
    end
  end

  describe "GET #edit" do
    it "user edit" do
      get :edit, { id: user.id }, { user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end

    it "user can't edit another user unless admin" do
      get :edit, { id: admin.id }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe "PATCH #update" do
    it "user updated" do
      patch :update, { id: user.id, user: user_params }, { user_id: user.id }
      expect(response).to redirect_to(assigns(:user))
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, { id: user.id }, session }

    context "an admin" do
      let(:session) { { user_id: admin.id } }

      it { expect(response).to redirect_to(users_path) }
    end

    context "a user" do
      let(:session) { { user_id: user.id } }

      it { expect(response).to redirect_to(root_path) }
    end
  end
end