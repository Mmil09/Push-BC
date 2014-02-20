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

ActiveRecord::Schema.define(version: 20140220172957) do

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
  end

  create_table "course_materials", force: true do |t|
    t.string "name"
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
  end

end
