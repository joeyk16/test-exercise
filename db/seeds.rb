User.create!(
  username:  "user_01",
  email: "user_01@yorlook.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  header_image: File.new("#{Rails.root}/app/assets/images/seeds/header/header_01.jpg"),
  avatar: File.new("#{Rails.root}/app/assets/images/seeds/avatar/avatar_01.png")
)

User.create!(
  username:  "user_02",
  email: "user_02@yorlook.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  header_image: File.new("#{Rails.root}/app/assets/images/seeds/header/header_01.jpg"),
  avatar: File.new("#{Rails.root}/app/assets/images/seeds/avatar/avatar_01.png")
)

User.create!(
  username:  "user_03",
  email: "user_03@yorlook.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  header_image: File.new("#{Rails.root}/app/assets/images/seeds/header/header_01.jpg"),
  avatar: File.new("#{Rails.root}/app/assets/images/seeds/avatar/avatar_01.png")
)

user_1 = User.find_by(username: "user_01")
user_2 = User.find_by(username: "user_02")
user_3 = User.find_by(username: "user_03")

Category.create!(
  name: "Men"
)

Category.create!(
  name: "Women"
)

Category.create!(
  name: "Shirt",
  ancestry: Category.find_by(name: "Men").id
)


Category.create!(
  name: "Jeans",
  ancestry: Category.find_by(name: "Women").id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_01.jpg"),
  user_id: user_1.id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_02.jpg"),
  user_id: user_1.id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_03.jpg"),
  user_id: user_2.id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_04.jpg"),
  user_id: user_2.id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_05.jpg"),
  user_id: user_3.id
)

Outfit.create!(
  caption: "This is a caption",
  outfit_image: File.new("#{Rails.root}/app/assets/images/seeds/outfits/outfit_06.jpg"),
  user_id: user_3.id
)

Paypal.create!(
  email: "user_01@yorlook.com",
  user_id: user_1.id,
  default: true
)

Paypal.create!(
  email: "user_02@yorlook.com",
  user_id: user_2.id,
  default: true
)

Paypal.create!(
  email: "user_02@yorlook.com",
  user_id: user_3.id,
  default: true
)

Address.create!(
  default_devlivery_address: true,
  default_billing_address: true,
  address_line_1: "1 Adelaide Street",
  address_line_2: nil,
  suburb: "Brisbane",
  state: "Queensland",
  postcode: 4000,
  country: "Australia",
  user_id: user_1.id
)

Address.create!(
  default_devlivery_address: true,
  default_billing_address: true,
  address_line_1: "2 Adelaide Street",
  address_line_2: nil,
  suburb: "Brisbane",
  state: "Queensland",
  postcode: 4000,
  country: "Australia",
  user_id: user_2.id
)

Address.create!(
  default_devlivery_address: true,
  default_billing_address: true,
  address_line_1: "3 Adelaide Street",
  address_line_2: nil,
  suburb: "Brisbane",
  state: "Queensland",
  postcode: 4000,
  country: "Australia",
  user_id: user_3.id
)

sizes = ["XXSmall", "XSmall", "Small", "Medium", "Large", "XLarge", "XXLarge"]

sizes.each do |size|
  Size.create(title: size, category_id: Category.find_by(name: "Shirt").id)
end

sizes.each do |size|
  Size.create(title: size, category_id: Category.find_by(name: "Jeans").id)
end

Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_1.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)

ProductImage.create!(
  product_id: Product.find(1).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image1xxl-1.jpg")
)

ProductImage.create!(
  product_id: Product.find(1).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image1xxl.jpg")
)

Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_2.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)

ProductImage.create!(
  product_id: Product.find(2).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image2xxl-1.jpg")
)

ProductImage.create!(
  product_id: Product.find(2).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image2xxl.jpg")
)

Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_3.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)

ProductImage.create!(
  product_id: Product.find(3).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image3xxl-1.jpg")
)

ProductImage.create!(
  product_id: Product.find(3).id,
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/image3xxl.jpg")
)
