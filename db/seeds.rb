User.create!(
  username:  "admin",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now,
  header_image: File.new("#{Rails.root}/app/assets/images/seeds/header/header_01.jpg"),
  avatar: File.new("#{Rails.root}/app/assets/images/seeds/avatar/avatar_01.png")
)

Category.create!(
  name: "Men"
  # ancestry:
)

Category.create!(
  name: "Women"
  # ancestry:
)

Product.create!(
  title: Faker::Lorem.word,
  price: Faker::Number.decimal(2),
  description: Faker::Lorem.paragraphs,
  user_id: User.find_by(username: "admin").id,
  category_id: Category.find_by(name: "Women").id,
  image: File.new("#{Rails.root}/app/assets/images/seeds/products/product_01.jpg")
)

Product.create!(
  title: Faker::Lorem.word,
  price: Faker::Number.decimal(2),
  description: Faker::Lorem.paragraphs,
  user_id: User.find_by(username: "admin").id,
  category_id: Category.find_by(name: "Women").id,
  image: File.new("#{Rails.root}/app/assets/images/seeds/products/product_02.jpg")
)
