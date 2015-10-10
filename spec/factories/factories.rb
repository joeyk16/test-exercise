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
    title Faker::Lorem.word
  end

  factory :category do
    name
  end

  factory :item do
    title
    price Faker::Number.number(3)
    description Faker::Lorem.sentence
    user_id Faker::Number.number(2)
    image_file_name Faker::Lorem.word
    category_id Faker::Number.number(2)
    category
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
    password_confirmation { |user| user.password }
    activated true
    description Faker::Lorem.sentence
    # activated_at "<%= Time.zone.now %>"
  end
end