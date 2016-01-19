# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160118100333) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry"

  create_table "outfit_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "outfit_id"
    t.boolean  "approved",   default: false
    t.boolean  "boolean",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "outfit_products", ["outfit_id"], name: "index_outfit_products_on_outfit_id"
  add_index "outfit_products", ["product_id"], name: "index_outfit_products_on_product_id"
  add_index "outfit_products", ["user_id"], name: "index_outfit_products_on_user_id"

  create_table "outfit_similar_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "outfit_id"
    t.boolean  "approved",   default: false
    t.boolean  "boolean",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "outfit_similar_products", ["outfit_id"], name: "index_outfit_similar_products_on_outfit_id"
  add_index "outfit_similar_products", ["product_id"], name: "index_outfit_similar_products_on_product_id"
  add_index "outfit_similar_products", ["user_id"], name: "index_outfit_similar_products_on_user_id"

  create_table "outfits", force: :cascade do |t|
    t.string   "outfit_image_file_name"
    t.string   "outfit_image_content_type"
    t.integer  "outfit_image_file_size"
    t.datetime "outfit_image_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "caption"
  end

  add_index "outfits", ["user_id"], name: "index_outfits_on_user_id"

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id"

  create_table "product_sizes", force: :cascade do |t|
    t.integer "quantity"
    t.integer "product_id"
    t.integer "size_id"
  end

  add_index "product_sizes", ["product_id"], name: "index_product_sizes_on_product_id"
  add_index "product_sizes", ["size_id"], name: "index_product_sizes_on_size_id"

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id"
    t.integer  "category_id"
    t.decimal  "price",                precision: 8, scale: 2
    t.text     "size_description"
    t.text     "shipping_description"
  end

  add_index "products", ["user_id", "created_at"], name: "index_products_on_user_id_and_created_at"
  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "sizes", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "sizes", ["category_id"], name: "index_sizes_on_category_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
    t.boolean  "admin",                     default: false
    t.text     "description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
