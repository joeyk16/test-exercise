require "rails_helper"
require "test_helper"

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:user, admin: false) }
  let!(:user02) { create(:user, admin: false) }
  let(:like) { create(:like) }
  let(:like_params) { like.attributes }

  describe "POST #create" do
    let!(:like_count) { Like.count }

    it "user creates like" do
      sign_in(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      post :create, { likes: like_params }
      expect(Like.count).to eq(like_count+1)
      expect(response).to redirect_to "where_i_came_from"
    end

    it "vistor redirects to login path" do
      post :create, { likes: like_params }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    let!(:like) { create(:like, user: user) }

    it "user deletes like" do
      sign_in(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      delete :destroy, { id: like.outfit.id }
      expect(assigns(:like)).to_not be_persisted
      expect(response).to redirect_to "where_i_came_from"
    end

    it "user can't delete different users like" do
      sign_in(user02)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      delete :destroy, { id: like.outfit.id }
      expect(response).to redirect_to "where_i_came_from"
    end

    it "vistor redirects to login path" do
      delete :destroy, { id: like.outfit.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
