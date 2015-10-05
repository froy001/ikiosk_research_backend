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

ActiveRecord::Schema.define(version: 20151005134744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.float    "value"
    t.integer  "question_id"
    t.integer  "interviewee_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "answers", ["interviewee_id"], name: "index_answers_on_interviewee_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "interviewees", force: :cascade do |t|
    t.string   "name"
    t.integer  "kiosk_id"
    t.string   "street"
    t.string   "city"
    t.float    "latitude",               null: false
    t.float    "longitude",              null: false
    t.integer  "age"
    t.integer  "gender",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interviewees", ["kiosk_id"], name: "index_interviewees_on_kiosk_id", using: :btree
  add_index "interviewees", ["latitude"], name: "index_interviewees_on_latitude", using: :btree
  add_index "interviewees", ["longitude"], name: "index_interviewees_on_longitude", using: :btree

  create_table "kiosks", force: :cascade do |t|
    t.string   "name",       limit: 20
    t.float    "latitude",              null: false
    t.float    "longitude",             null: false
    t.string   "street",     limit: 30
    t.string   "city",       limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "kiosks", ["latitude"], name: "index_kiosks_on_latitude", using: :btree
  add_index "kiosks", ["longitude"], name: "index_kiosks_on_longitude", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "content",                   null: false
    t.integer  "question_type", default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "role",                   default: 0,  null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "answers", "interviewees", on_delete: :cascade
  add_foreign_key "answers", "questions", on_delete: :cascade
  add_foreign_key "interviewees", "kiosks", on_delete: :cascade
end
