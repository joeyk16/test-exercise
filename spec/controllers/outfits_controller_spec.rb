require 'rails_helper'

RSpec.describe OutfitsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Outfit. As you add validations to Outfit, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) {
  #   desciption => "this is a test description"
  # }

  # let(:invalid_attributes) {
  #   desciption => ""
  # }

  # # This should return the minimal set of values that should be in the session
  # # in order to pass any filters (e.g. authentication) defined in
  # # OutfitsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  # describe "GET #index" do
  #   it "assigns all outfits as @outfits" do
  #     outfit = Outfit.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:outfits)).to eq([outfit])
  #   end
  # end

  # describe "GET #show" do
  #   it "assigns the requested outfit as @outfit" do
  #     outfit = Outfit.create! valid_attributes
  #     get :show, {:id => outfit.to_param}, valid_session
  #     expect(assigns(:outfit)).to eq(outfit)
  #   end
  # end

  # describe "GET #new" do
  #   it "assigns a new outfit as @outfit" do
  #     get :new, {}, valid_session
  #     expect(assigns(:outfit)).to be_a_new(Outfit)
  #   end
  # end

  # describe "GET #edit" do
  #   it "assigns the requested outfit as @outfit" do
  #     outfit = Outfit.create! valid_attributes
  #     get :edit, {:id => outfit.to_param}, valid_session
  #     expect(assigns(:outfit)).to eq(outfit)
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Outfit" do
  #       expect {
  #         post :create, {:outfit => valid_attributes}, valid_session
  #       }.to change(Outfit, :count).by(1)
  #     end

  #     it "assigns a newly created outfit as @outfit" do
  #       post :create, {:outfit => valid_attributes}, valid_session
  #       expect(assigns(:outfit)).to be_a(Outfit)
  #       expect(assigns(:outfit)).to be_persisted
  #     end

  #     it "redirects to the created outfit" do
  #       post :create, {:outfit => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Outfit.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved outfit as @outfit" do
  #       post :create, {:outfit => invalid_attributes}, valid_session
  #       expect(assigns(:outfit)).to be_a_new(Outfit)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, {:outfit => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested outfit" do
  #       outfit = Outfit.create! valid_attributes
  #       put :update, {:id => outfit.to_param, :outfit => new_attributes}, valid_session
  #       outfit.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested outfit as @outfit" do
  #       outfit = Outfit.create! valid_attributes
  #       put :update, {:id => outfit.to_param, :outfit => valid_attributes}, valid_session
  #       expect(assigns(:outfit)).to eq(outfit)
  #     end

  #     it "redirects to the outfit" do
  #       outfit = Outfit.create! valid_attributes
  #       put :update, {:id => outfit.to_param, :outfit => valid_attributes}, valid_session
  #       expect(response).to redirect_to(outfit)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns the outfit as @outfit" do
  #       outfit = Outfit.create! valid_attributes
  #       put :update, {:id => outfit.to_param, :outfit => invalid_attributes}, valid_session
  #       expect(assigns(:outfit)).to eq(outfit)
  #     end

  #     it "re-renders the 'edit' template" do
  #       outfit = Outfit.create! valid_attributes
  #       put :update, {:id => outfit.to_param, :outfit => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested outfit" do
  #     outfit = Outfit.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => outfit.to_param}, valid_session
  #     }.to change(Outfit, :count).by(-1)
  #   end

  #   it "redirects to the outfits list" do
  #     outfit = Outfit.create! valid_attributes
  #     delete :destroy, {:id => outfit.to_param}, valid_session
  #     expect(response).to redirect_to(outfits_url)
  #   end
  # end

end
