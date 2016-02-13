require 'rails_helper'

RSpec.describe ShippingMethodsController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:shipping_method) { create(:shipping_method, user_id: user.id) }

  let(:shipping_method_params) { shipping_method.attributes }

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
    it "user creates shipping_method" do
      sign_in(user)
      post :create, { shipping_method: shipping_method_params, user_id: user }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:shipping_method)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { user_id: user }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "user edits shipping_method" do
      sign_in(user)
      get :edit, { id: shipping_method.id, user_id: user.id }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
      expect(assigns(:shipping_method)).to eq(shipping_method)
      expect(assigns(:shipping_method)).to be_persisted
    end

    it "vistor redirects to login path" do
      get :edit, { id: shipping_method.id, user_id: user.id }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update" do
    it "user updates outfit" do
      sign_in(user)
      patch :update, { id: shipping_method.id, user_id: user.id, shipping_method: shipping_method_params }
      expect(response).to redirect_to(user_my_account_path(user))
      expect(assigns(:shipping_method)).to eq(shipping_method)
      expect(assigns(:shipping_method)).to be_persisted
    end

    it "vistor redirects to login path" do
      patch :update, { id: shipping_method.id, user_id: user.id, shipping_method: shipping_method_params }, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes outfit" do
      sign_in(user)
      delete :destroy, { id: shipping_method.id, user_id: user.id }
      expect(assigns(:shipping_method)).to_not be_persisted
      expect(response).to redirect_to(user_my_account_path(user))
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: shipping_method.id, user_id: user.id }, { }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
