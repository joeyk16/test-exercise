User.create!(
  username:  "admin",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
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

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_01.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_02.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_03.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_04.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_05.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Outfit.create!(
#   caption: Faker::Lorem.sentence(2),
#   outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_06.jpg"),
#   user_id: User.find_by(username: "admin").id
# )

# Product.create!(
#   title: Faker::Lorem.word,
#   price: Faker::Number.decimal(2),
#   description: Faker::Lorem.paragraphs,
#   user_id: User.find_by(username: "admin").id,
#   category_id: Category.find_by(name: "Women").id,
# )

# ProductImage.create!(
#   product_id: nil
#   product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image1xxl-1.jpg")
# )

# # Product.create!(
# #   title: Faker::Lorem.word,
# #   price: Faker::Number.decimal(2),
# #   description: Faker::Lorem.paragraphs,
# #   user_id: User.find_by(username: "admin").id,
# #   category_id: Category.find_by(name: "Women").id,
# #   image: File.new("#{Rails.root}/app/assets/images/seeds/products/product_02.jpg")
# # )
