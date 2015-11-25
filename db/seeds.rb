User.create!(
  username:  "admin",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
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
  category_id: Category.find_by(name: "Men").id,
  image: File.new("#{Rails.root}/spec/fixtures/image.jpg")
)
