require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:address) { create(:address, user_id: user.id) }

  let(:address_params) { address.attributes }

  describe "GET #new" do
    it "user renders new template" do
      sign_in(user)
      get :new, { user_id: user }
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end

    it "vistor redirects to login path" do
      get :new, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    it "user creates address" do
      sign_in(user)
      post :create, { address: address_params, user_id: user }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:address)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "user edits address" do
      sign_in(user)
      get :edit, { id: address.id, user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:address)).to eq(address)
    end

    it "vistor redirects to login path" do
      get :edit, { id: address.id, user_id: user.id }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update" do
    it "user updates outfit" do
      sign_in(user)
      patch :update, { id: address.id, user_id: user.id, address: address_params }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:address)).to eq(address)
    end

    it "vistor redirects to login path" do
      patch :update, { id: address.id, user_id: user.id, address: address_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes outfit" do
      sign_in(user)
      delete :destroy, { id: address.id, user_id: user.id }
      expect(response).to redirect_to(user_my_account_path(user))
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: address.id, user_id: user.id }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
