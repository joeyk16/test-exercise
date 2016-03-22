require 'rails_helper'

RSpec.describe PaypalsController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:user_01) { create(:user, admin: false) }
  let!(:paypal) { create(:paypal, user_id: user.id) }
  let!(:paypal_01) { create(:paypal, user_id: user_01.id) }

  let(:paypal_params) { paypal.attributes }

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
    it "user creates paypal" do
      sign_in(user)
      post :create, { paypal: paypal_params, user_id: user }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:paypal)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "user edits paypal" do
      sign_in(user)
      get :edit, { id: paypal.id, user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:paypal)).to eq(paypal)
    end

    it "user can't edit different users paypal account" do
      sign_in(user)
      get :edit, { id: paypal_01.id, user_id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it "vistor redirects to login path" do
      get :edit, { id: paypal.id, user_id: user.id }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update" do
    it "user updates outfit" do
      sign_in(user)
      patch :update, { id: paypal.id, user_id: user.id, paypal: paypal_params }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:paypal)).to eq(paypal)
    end

    it "user can't edit different users paypal account" do
      sign_in(user)
      patch :update, { id: paypal_01.id, user_id: user.id, paypal: paypal_params }
      expect(response).to redirect_to(root_path)
    end

    it "vistor redirects to login path" do
      patch :update, { id: paypal.id, user_id: user.id, paypal: paypal_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes outfit" do
      sign_in(user)
      delete :destroy, { id: paypal.id, user_id: user.id }
      expect(assigns(:paypal)).to_not be_persisted
      expect(response).to redirect_to(user_my_account_path(user))
    end

    it "user can't edit different users paypal account" do
      sign_in(user)
      delete :destroy, { id: paypal_01.id, user_id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: paypal.id, user_id: user.id }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
