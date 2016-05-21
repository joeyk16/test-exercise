require "rails_helper"

RSpec.describe SizesController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:category) { create(:category, name: "Shirt") }

  let!(:size) { create(:size, category_id: category.id) }

  let!(:sizes) do
    [size] + 4.times.map { create(:size, category_id: category.id) }
  end

  let(:size_params) { size_params = build(:size).attributes }

  describe "GET #index" do
    it "renders template and shows sizes logged in as admin" do
      sign_in(admin)
      get :index, {}
      expect(response).to render_template(:index)
      expect(assigns(:sizes)).to eq(sizes)
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
    it "renders template and shows size logged in as admin" do
      sign_in(admin)
      get :show, { id: size.id }
      expect(response).to render_template(:show)
    end

    it "redirects visitor" do
      get :show, { id: size.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :show, { id: size.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "renders new template logged in as admin" do
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
    it "creates size logged in as admin" do
      sign_in(admin)
      post :create, { size: size_params }
      expect(assigns(:size).errors).to be_empty
      expect(response).to redirect_to(sizes_path)
    end

    it "redirects visitor" do
      get :create, { size: size_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :create, { size: size_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #edit" do
    it "edit size logged in as admin" do
      sign_in(admin)
      get :edit, { id: size.id, }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:size)).to eq(size)
    end

    it "redirects visitor" do
      get :edit, { id: size.id, }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      get :edit, { id: size.id, }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #update" do
    it "update size logged in as admin" do
      sign_in(admin)
      patch :update, { id: size.id, size: size_params }
      expect(response).to redirect_to(sizes_path)
      expect(flash[:success]).to eq("Size was successfully updated")
    end

    it "redirects visitor" do
      patch :update, { id: size.id, size: size_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      patch :update, { id: size.id, size: size_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "delete size logged in as admin" do
      sign_in(admin)
      delete :destroy, { id: size.id }
      expect(response).to redirect_to(sizes_path)
    end

    it "redirects visitor" do
      delete :destroy, { id: size.id, size: size_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end

    it "user renders template and redirects" do
      sign_in(user)
      delete :destroy, { id: size.id, size: size_params }
      expect(response).to redirect_to(root_path)
    end
  end
end
