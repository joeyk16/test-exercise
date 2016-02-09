require "rails_helper"
require "test_helper"

RSpec.describe UsersController, type: :controller do
  let!(:admin) { create(:user, password: "Password123", admin: true) }
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let(:other_user) { create(:user, password: "Password456", admin: false) }

  let!(:update_params) do
    { id: user.id, user_id: user.id, user: user }
  end

  let!(:users) do
    [admin, user] + 3.times.map { create(:user) }
  end

  let!(:user_params) { user_params = { username: "username#{rand(1000)}",
                                       email: "user#{rand(1000)}@factory.com",
                                       password: "Password123",
                                       description: "Nihil eligendi ab debitis iure.",
                                      } }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  describe "GET #index" do
    #active admin will do all this just testing users and visitors

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "user renders template and shows user" do
      sign_in(user)
      get :show, id: user.id
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    #active admin will do all this just testing users and visitors

    it "redirects visitor" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    it "user created" do
      sign_in(admin)
      post :create, user: user_params
      expect(assigns(:user)).to be_persisted
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      post :create, user: user_params
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user trys to create user but redirects" do
      sign_in(user)
      post :create, user: user_params
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #edit" do
    it "user edit" do
      sign_in(user)
      get :edit, { id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end

    it "user can't edit another user unless admin" do
      sign_in(user)
      get :edit, { id: admin.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      get :edit, { id: admin.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update" do
    it "user updated" do
      sign_in(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      patch :update, { id: user.id, user: user_params }
      expect(response).to redirect_to "where_i_came_from"
      expect(assigns(:user)).to eq(user)
    end

    it "redirects visitor" do
      patch :update, { id: user.id, user: user_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "other_user trys to update user but redirects" do
      sign_in(other_user)
      patch :update, { id: user.id, user: user_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "admin deletes" do
      sign_in(admin)
      delete :destroy, id: user
      expect(response).to redirect_to(users_path)
      expect(flash[:success]).to eq("User deleted")
    end

    it "user can't delete another user unless admin" do
      sign_in(other_user)
      delete :destroy, { id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects visitor" do
      delete :destroy, { id: user.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
