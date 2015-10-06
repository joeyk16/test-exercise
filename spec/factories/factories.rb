FactoryGirl.define do
  factory :category do
    name Faker::Lorem.word
  end

  factory :category_size do
    category_id Faker::Number.number(2)
    size_id Faker::Number.number(2)
  end

  factory :size do
    title Faker::Lorem.word
  end

  factory :item do
    title Faker::Lorem.word
    price Faker::Number.number(3)
    description Faker::Lorem.sentence
    user_id Faker::Number.number(2)
    image_file_name Faker::Lorem.word
    category_id Faker::Number.number(2)
  end

  factory :user do
    username Faker::Lorem.word
    email Faker::Internet.email
    admin "false"
    password_digest Faker::Internet.password(8)
    # activated "true"
    # activated_at "<%= Time.zone.now %>"
  end

  factory :admin do
    username Faker::Lorem.word
    email Faker::Internet.email
    admin "true"
    password_digest Faker::Internet.password(8)
    # activated "true"
    # activated_at "<%= Time.zone.now %>"
  end
end