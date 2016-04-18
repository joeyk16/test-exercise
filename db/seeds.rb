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

User.all.each do |user|
  ShippingMethod.create!(name: Faker::Commerce.product_name, user_id: user.id, price_in_cents: 1995, country: "Australia")
end

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

User.all.each do |user|
  Address.create!(
    default_devlivery_address: true,
    default_billing_address: true,
    address_line_1: Faker::Address.street_address,
    address_line_2: nil,
    suburb: "Brisbane",
    state: "Queensland",
    postcode: 4000,
    country: "Australia",
    user_id: user.id
  )
end

sizes = ["XXSmall", "XSmall", "Small", "Medium", "Large", "XLarge", "XXLarge"]

sizes.each do |size|
  Size.create(title: size, category_id: Category.find_by(name: "Shirt").id)
end

sizes.each do |size|
  Size.create(title: size, category_id: Category.find_by(name: "Jeans").id)
end

p1 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_1.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p1.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/mens_clothes_01.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p1.id)
end

p2 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_2.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p2.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/mens_clothes_02.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p2.id)
end

p3 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_3.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p3.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/mens_clothes_03.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p3.id)
end

p4 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_1.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p4.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/womens_clothes_01.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p4.id)
end

p5 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_2.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p5.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/womens_clothes_02.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p5.id)
end

p6 = Product.create!(
  title: Faker::Lorem.characters(6),
  description: Faker::Lorem.sentence,
  user_id: user_3.id,
  category_id: Category.find_by(name: "Shirt").id,
  size_description: Faker::Lorem.sentence,
  shipping_description: Faker::Lorem.sentence,
  price_in_cents: Faker::Number.number(4)
)
p6.product_images.create(
  product_image: File.new("#{Rails.root}/app/assets/images/seeds/products/womens_clothes_03.jpg")
)
Size.where(category_id: Category.find_by(name: "Shirt").id ).each do |size|
  ProductSize.create!(quantity: Faker::Number.number(1), size_id: size.id, product_id: p6.id)
end

Product.all.each do |product|
  outfit = Outfit.order("RANDOM()").first
  OutfitProduct.create!(
    user_id: product.user.id,
    product_id: product.id,
    approved: true,
    outfit_id: outfit.id,
    boolean: false,
    outfit_user_id: outfit.user_id
  )
end
