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

  factory :size do
    title
  end

  factory :category do
    name
  end

  factory :outfit_product do
   user_id Faker::Number.number(2)
   product_id Faker::Number.number(2)
   outfit_id Faker::Number.number(2)
   approved true
  end

  factory :product do
    sequence(:title) { |n| "title#{n}" }
    price Faker::Number.number(3)
    description Faker::Lorem.sentence
    user_id Faker::Number.number(2)
    category
    user
  end

  factory :product_size do
    quantity Faker::Number.number(2)
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
    activated true
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
