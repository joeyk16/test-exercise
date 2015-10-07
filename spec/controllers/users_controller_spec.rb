require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user, password: "Password123", admin: true) }

  let!(:users) do
    [user] + 3.times.map { create(:user) }
  end

  let!(:category) { create(:category, name: "Women") }
  let!(:category1) { create(:category, name: "Men") }

  describe "GET #index" do
    it "user renders template and shows users" do
      get :index, {}, { user_id: user.id }
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
      expect(assigns(:users).map(&:id)).to eq users.map(&:id)
    end

    it "redirects visitor" do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end
end