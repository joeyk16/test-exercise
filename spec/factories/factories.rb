FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@factory.com"
  end

  sequence :username do |n|
    "username#{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :title do |n|
    "title#{n}"
  end

  factory :category_size do
    category_id Faker::Number.number(2)
    size_id Faker::Number.number(2)
  end

  factory :category do
    name { Faker::Lorem.word }
  end

  factory :outfit_product do
   user
   product_id Faker::Number.number(2)
   outfit_id Faker::Number.number(2)
   approved true
  end

  factory :like do
    user
    outfit
  end

  factory :product do
    title { Faker::Lorem.word }
    price_in_cents Faker::Number.number(4)
    description Faker::Lorem.sentence
    user_id Faker::Number.number(2)
    category
    user

    after(:create) do |product|
      size = create(:size)
      create(:product_size, product: product, size_id: size.id, quantity: Faker::Number.number(2))
    end
  end

  factory :cart_item do
    quantity Faker::Number.number(1)
    product
    outfit
    size
    user
    shipping_method
  end

  factory :size do
    title Faker::Lorem.word
    category
  end

  factory :product_size do
    quantity Faker::Number.number(2)
  end

  factory :shipping_method do
    name
    country Faker::Address.country
    price_in_cents Faker::Number.number(2)
    user
  end

  factory :address do
    address_line_1 Faker::Address.street_address
    suburb Faker::Address.city
    state Faker::Address.state
    postcode Faker::Address.postcode
    country Faker::Address.country
    user
  end

  factory :relationship do
    following_id Faker::Number.number(2)
  end

  factory :paypal do
    default true
    email
    user
  end

  factory :outfit do
    caption Faker::Lorem.word
    user_id Faker::Number.number(2)
    outfit_image File.open("#{Rails.root}/spec/fixtures/image.jpg")
    tag_list ["shoes", "short", "shirt"]
  end

  factory :user do
    username
    email
    admin false
    password Faker::Internet.password(8)
    password_confirmation { |user| user.password }
    description Faker::Lorem.sentence
    # activated_at "<%= Time.zone.now %>"
  end

  factory :admin do
    username
    email
    admin true
    password Faker::Internet.password(8)
    password_confirmation { |admin| admin.password }
    activated true
    description Faker::Lorem.sentence
    # activated_at "<%= Time.zone.now %>"
  end
end
