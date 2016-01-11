require "rails_helper"

RSpec.describe ProductSizesController, type: :controller do
  let!(:user) { create(:user, password: "Password456", admin: false) }
  let!(:admin) { create(:user, password: "Password123", admin: true) }

  let!(:product) { create(:product) }

  let!(:category) { create(:category, name: "Shirt") }

  let!(:size) { create(:size, category_id: category.id) }

  let!(:product_size) { create(:product_size, product_id: product.id, size_id: size.id) }

  let(:product_size_params) {
    product_size =
    {
      product_id: product.id,
      size_id: size.id,
      quantity: Faker::Number.number(2)
    }
  }

  describe "POST #create" do
    context "creates size logged in as admin" do
      before do
        product_size_count = ProductSize.count
        post :create, { product_size: product_size_params }, { user_id: admin.id }
      end

      # it "saves and ProductSize.count increases by 1" do
      #   # expect(product_size_count).to eq(product_size_count + 1)
      # end
    end

    # it "redirects visitor" do
    #   get :create, { product_size: product_size_params }
    #   expect(response).to redirect_to(login_url)
    # end

    # it "user renders template and redirects" do
    #   get :create, { product_size: product_size_params }, { user_id: user.id }
    #   expect(response).to redirect_to(root_path)
    # end
  end
end
