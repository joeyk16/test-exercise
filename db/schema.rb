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

ActiveRecord::Schema.define(version: 20151028094236) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry"

  create_table "category_sizes", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "size_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "category_sizes", ["category_id"], name: "index_category_sizes_on_category_id"
  add_index "category_sizes", ["size_id"], name: "index_category_sizes_on_size_id"

  create_table "outfit_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "outfit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "outfit_products", ["outfit_id"], name: "index_outfit_products_on_outfit_id"
  add_index "outfit_products", ["product_id"], name: "index_outfit_products_on_product_id"

  create_table "outfit_similar_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "outfit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "outfit_similar_products", ["outfit_id"], name: "index_outfit_similar_products_on_outfit_id"
  add_index "outfit_similar_products", ["product_id"], name: "index_outfit_similar_products_on_product_id"

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

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "category_id"
  end

  add_index "products", ["user_id", "created_at"], name: "index_products_on_user_id_and_created_at"
  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "sizes", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string   "email"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                     default: false
    t.string   "activation_digest"
    t.boolean  "activated",                 default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.string   ">"
    t.datetime "reset_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description"
    t.string   "header_image_file_name"
    t.string   "header_image_content_type"
    t.integer  "header_image_file_size"
    t.datetime "header_image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
