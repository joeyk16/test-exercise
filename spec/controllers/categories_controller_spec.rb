require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  let!(:categories) do
    [category, category1] + 3.times.map { create(:category) }
  end

  let!(:category_params) { category_params = build(:category).attributes }

  describe "GET #index" do
    it "renders template and shows category as admin user" do
      sign_in(admin)
      get :index, {}
      expect(response).to render_template(:index)
      expect(assigns(:categories)).to eq(categories)
    end

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :index, {}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "renders template and shows category as admin user" do
      sign_in(admin)
      get :show, { id: category.id }
      expect(response).to render_template(:show)
    end

    it "redirects visitor" do
      get :show, { id: category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :show, { id: category.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "renders template as admin user" do
      sign_in(admin)
      get :new, {}
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "redirects visitor" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :new, {}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    it "creates category as admin user" do
      sign_in(admin)
      post :create, { category: category_params }
      expect(assigns(:category).errors).to be_empty
      expect(response).to redirect_to(categories_path)
    end

    it "redirects visitor" do
      get :create, { category: category_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :create, { category: category_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #edit" do
    it "edits category as admin user" do
      sign_in(admin)
      get :edit, { id: category.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:category)).to eq(category)
    end

    it "redirects visitor" do
      get :edit, { id: category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :edit, { id: category.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #update" do
    it "updates category as admin user" do
      sign_in(admin)
      patch :update, { id: category.id, category: category_params }
      expect(response).to redirect_to(categories_path)
      expect(assigns(:category)).to eq(category)
    end

    it "redirects visitor" do
      patch :update, { id: category.id, category: category_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      patch :update, { id: category.id, category: category_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys category as admin user" do
      sign_in(admin)
      delete :destroy, { id: category.id }
      expect(response).to redirect_to(categories_path)
    end

    it "as unauthorised user" do
      sign_in(user)
      delete :destroy, { id: category.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
