require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let!(:user_01) { create(:user, admin: false) }
  let!(:user_02) { create(:user, admin: false) }

  let!(:relationships_followings) do
    3.times.map { create(:relationship, user: user_01, following_id: create(:user, admin: false).id ) }
  end

  let!(:relationships_followers) do
    3.times.map { create(:relationship, user: create(:user, admin: false), following_id: user_01.id ) }
  end

  let(:relationship_params) { relationships_followings[0].attributes }

  describe "#following" do
    it "shows what the user is following" do
      sign_in(user_01)
      get :following, user_id: user_01
      expect(response).to render_template(:following)
      expect(response).to have_http_status(:success)
      expect(assigns(:relationships)).to eq(relationships_followings)
    end

    it "vistor redirects to login path" do
      get :following, user_id: user_01
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#followers" do
    it "shows followers the user has" do
      sign_in(user_01)
      get :followers, user_id: user_01
      expect(response).to render_template(:followers)
      expect(response).to have_http_status(:success)
      expect(assigns(:relationships)).to eq(relationships_followers)
    end

    it "vistor redirects to login path" do
      get :followers, user_id: user_01
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    before { relationship_params["user_id"] = user_02.id }

    it "user creates relationship" do
      sign_in(user_01)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      post :create, { relationship: relationship_params, user_id: user_01 }
      expect(response).to redirect_to "where_i_came_from"
      expect(assigns(:relationship)).to be_persisted
    end

    it "vistor redirects to login path" do
      post :create, { relationship: relationship_params, user_id: user_01 }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "user deletes relationship" do
      sign_in(user_01)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      delete :destroy, { id: relationships_followings[0].id, user_id: user_01.id }
      expect(response).to redirect_to "where_i_came_from"
      expect(assigns(:relationship)).to_not be_persisted
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: relationships_followings[0].id, user_id: user_01.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
