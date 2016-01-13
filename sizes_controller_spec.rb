require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:category) { create(:category, name: "Shirt") }
  let!(:category1) { create(:category, name: "Short") }

  let!(:size) { create(:size, category: category) }

  let!(:sizes) do
    5.times.map { create(:size, category: category) }
  end

  describe "GET #index" do
    it "renders template and shows category as admin user" do
      get :index, {}, { user_id: admin.id }
      expect(response).to render_template(:index)
      expect(assigns(:sizes)).to eq(sizes)
    end

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      get :index, {}, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "renders template and shows category as admin user" do
      get :show, { id: size.id }, { user_id: admin.id }
      expect(response).to render_template(:show)
    end

    it "redirects visitor" do
      get :show, { id: size.id }
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      get :show, { id: size.id }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "renders template as admin user" do
      get :new, {}, { user_id: admin.id }
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "redirects visitor" do
      get :new
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      get :new, {}, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    it "creates category as admin user" do
      post :create, { category: category_params }, { user_id: admin.id }
      expect(assigns(:category).errors).to be_empty
      expect(response).to redirect_to(categories_path)
    end

    it "redirects visitor" do
      get :create, { category: category_params }
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      get :create, { category: category_params }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #edit" do
    it "edits category as admin user" do
      get :edit, { id: category.id }, { user_id: admin.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:category)).to eq(category)
    end

    it "redirects visitor" do
      get :edit, { id: category.id }
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      get :edit, { id: category.id }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #update" do
    it "updates category as admin user" do
      patch :update, { id: category.id, category: category_params }, { user_id: admin.id }
      expect(response).to redirect_to(categories_path)
      expect(assigns(:category)).to eq(category)
    end

    it "redirects visitor" do
      patch :update, { id: category.id, category: category_params }, {}
      expect(response).to redirect_to(login_url)
    end

    it "user renders template and redirects" do
      patch :update, { id: category.id, category: category_params }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys category as admin user" do
      delete :destroy, { id: category.id }, { user_id: admin.id }
      expect(response).to redirect_to(categories_path)
    end

    it "as unauthorised user" do
      delete :destroy, { id: category.id }, { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
