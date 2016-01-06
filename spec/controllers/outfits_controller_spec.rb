require 'rails_helper'

RSpec.describe OutfitsController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:outfit) { create(:outfit) }
  let!(:outfit_with_user) { create(:outfit, user_id: user.id) }

  let!(:outfits) do
    [outfit] + 3.times.map { create(:outfit) }
  end

  let!(:outfits_of_user) do
    [outfit_with_user] + 3.times.map { create(:outfit, user_id: user.id) }
  end

  let(:outfit_params) { outfit_with_user.attributes }

  describe "GET #index" do
    it "user sees only their outfits" do
      get :index, { user_id: user.id }, { user_id: user.id }
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
      expect(assigns(:outfits)).to eq(outfits_of_user)
    end

    it "vistor redirects to login path" do
      get :index, { user_id: user }, { }
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET #show" do
    it "show outfit" do
      get :show, { id: outfit_with_user.id, user_id: user }, { }
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
      expect(assigns(:outfit)).to eq(outfit_with_user)
    end
  end

  describe "GET #new" do
    it "user renders new template" do
      get :new, { user_id: user }, { user_id: user.id }
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "vistor redirects to login path" do
      get :new, { user_id: user }, { }
      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST #create" do
    it "user creates outfit" do
      post :create, { outfit: outfit_params, user_id: user }, { user_id: user.id }
      expect(assigns(:outfit)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { user_id: user }, { }
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET #edit" do
    it "user edits outfit" do
      get :edit, { id: outfit_with_user.id, user_id: user.id }, { user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:outfit)).to eq(outfit_with_user)
    end

    it "vistor redirects to login path" do
      get :edit, { id: outfit_with_user.id, user_id: user.id }, {}
      expect(response).to redirect_to(login_path)
    end
  end

  describe "PATCH #update" do
    it "user updates outfit" do
      patch :update, { id: outfit_with_user.id, user_id: user.id, outfit: outfit_params }, { user_id: user.id }
      expect(response).to redirect_to(user_outfit_path(user, outfit_with_user))
      expect(assigns(:outfit)).to eq(outfit_with_user)
    end

    it "vistor redirects to login path" do
      patch :update, { id: outfit_with_user.id, user_id: user.id, outfit: outfit_params }, {}
      expect(response).to redirect_to(login_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes outfit" do
      delete :destroy, { id: outfit_with_user.id, user_id: user.id }, { user_id: user.id }
      expect(response).to redirect_to(user_outfits_path(user))
      expect(assigns(:outfit)).to eq(outfit_with_user)
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: outfit_with_user.id, user_id: user.id }, { }
      expect(response).to redirect_to(login_path)
    end
  end
end
