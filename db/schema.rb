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

ActiveRecord::Schema.define(version: 20160611083155) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 4294967295
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "leaders", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "phone",                 limit: 255
    t.string   "sex",                   limit: 255
    t.date     "birth"
    t.string   "workplace",             limit: 255
    t.string   "income",                limit: 255
    t.string   "payoff_type",           limit: 255
    t.string   "job",                   limit: 255
    t.string   "has_credit_card",       limit: 255
    t.string   "loan_experience",       limit: 255
    t.string   "mortgage",              limit: 255
    t.string   "has_car_loan",          limit: 255
    t.string   "has_accumulation_fund", limit: 255
    t.string   "has_life_insurance",    limit: 255
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "leaders", ["user_id"], name: "index_leaders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "openid",     limit: 255
    t.string   "avatar",     limit: 255
    t.string   "number",     limit: 255
    t.string   "name",       limit: 255
    t.string   "cell",       limit: 255
    t.string   "email",      limit: 255
    t.string   "id_card",    limit: 255
    t.string   "bank_card",  limit: 255
    t.string   "alipay",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "feedbacks", "users"
  add_foreign_key "leaders", "users"
end
