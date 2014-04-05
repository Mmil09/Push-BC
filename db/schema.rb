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

ActiveRecord::Schema.define(version: 20140403120911) do

  create_table "bootcamp_materials", force: true do |t|
    t.integer "bootcamp_id"
    t.integer "material_id"
  end

  create_table "bootcamps", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "format"
    t.string  "length"
    t.string  "class_size"
    t.string  "sessions"
    t.string  "hours"
    t.string  "minimum_skill"
    t.boolean "placement_test"
    t.string  "prep_work"
    t.string  "cost"
    t.string  "refund"
    t.string  "financing"
    t.string  "deposit"
    t.string  "payment_plan"
    t.boolean "job_assistance"
    t.boolean "housing"
    t.boolean "visa_assistance"
    t.string  "email"
    t.string  "phone"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.string  "website"
    t.string  "slug"
  end

  add_index "bootcamps", ["slug"], name: "index_bootcamps_on_slug"

  create_table "course_materials", force: true do |t|
    t.string "name"
    t.string "slug"
  end

  add_index "course_materials", ["slug"], name: "index_course_materials_on_slug"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "replies", force: true do |t|
    t.text     "response"
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "rating"
    t.text     "background"
    t.text     "instruction"
    t.text     "overall"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "bootcamp_id"
  end

  create_table "user_bootcamps", force: true do |t|
    t.integer "bootcamp_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "type"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug"

end
