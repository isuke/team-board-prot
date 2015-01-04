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

ActiveRecord::Schema.define(version: 20150104032722) do

  create_table "article_logs", force: true do |t|
    t.integer  "article_id",        null: false
    t.string   "title",             null: false
    t.text     "content"
    t.datetime "created_at"
    t.integer  "user_id"
    t.text     "formatted_content"
  end

  add_index "article_logs", ["article_id", "created_at"], name: "index_article_logs_on_article_id_and_created_at", unique: true
  add_index "article_logs", ["article_id"], name: "index_article_logs_on_article_id"

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id",    null: false
  end

  create_table "comments", force: true do |t|
    t.integer  "article_id",        null: false
    t.integer  "user_id"
    t.text     "content",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "formatted_content", null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"

  create_table "teams", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_users", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",       default: 30, null: false
  end

  add_index "teams_users", ["team_id", "user_id"], name: "index_teams_users_on_team_id_and_user_id", unique: true
  add_index "teams_users", ["team_id"], name: "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], name: "index_teams_users_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
