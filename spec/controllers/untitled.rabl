  describe "POST #create" do
    context "if user authenticated" do
      before { sign_in user }

      context "with valid attributes" do
        before { post :create, payment: payment_params }

        it { expect(response).to redirect_to(assigns(:payment)) }
        it { expect(assigns(:payment)).to be_persisted }
      end

      context "with invalid attribute" do
        before do
          payment_params[:payee_id] = nil
          post :create, payment: payment_params
        end

        it { expect(response).to render_template(:new) }
        it { expect(assigns(:payment)).to_not be_persisted }
      end
    end

    context "not authenticated" do
      before { post :create, payment: payment_params }
      it { expect(response).to_not have_http_status(:success) }
    end
  end

  #   describe "GET #new" do
  #   context "user authenticated" do
  #     before do
  #       sign_in user
  #       session[:current_account_id] = user.accounts.first.id
  #       get :new
  #     end

  #     it { expect(response).to render_template(:new) }
  #     it { expect(response).to have_http_status(:success) }
  #   end

  #   context "not authenticated" do
  #     it "redirects to user login" do
  #       get :new
  #       expect(response).to redirect_to(new_user_session_path)
  #     end
  #   end
  # end

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:admin) { create(:user, password: "Password123", admin: true) }
  let!(:user) { create(:user, password: "Password456", admin: false) }

  let!(:users) do
    [admin, user] + 3.times.map { create(:user) }
  end

  let!(:user_params) { user.attributes }

  describe "POST #create" do
    before do
      post :create, user: user_params
    end

    it "user created" do
      expect(assigns(:user)).to be_persisted
    end
  end
end