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

ActiveRecord::Schema.define(version: 20151004141354) do

  create_table "book_suggestions", force: :cascade do |t|
    t.string   "isbn",        limit: 255
    t.string   "name",        limit: 255, null: false
    t.string   "authors",     limit: 255, null: false
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "isbn",        limit: 255,                 null: false
    t.string   "name",        limit: 255,                 null: false
    t.string   "authors",     limit: 255,                 null: false
    t.string   "description", limit: 255
    t.integer  "status",      limit: 4,                   null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "isDeleted",               default: false
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id",      limit: 4, null: false
    t.integer  "book_id",      limit: 4, null: false
    t.datetime "dateIssued",             null: false
    t.datetime "dateReturned"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reservations", ["book_id"], name: "fk_rails_bff51a5a6e", using: :btree
  add_index "reservations", ["user_id"], name: "fk_rails_48a92fce51", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 100,                 null: false
    t.string   "email",      limit: 50,                  null: false
    t.string   "password",   limit: 255,                 null: false
    t.integer  "role",       limit: 4,                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "isDeleted",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "waitlists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "book_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "waitlists", ["book_id"], name: "index_waitlists_on_book_id", using: :btree
  add_index "waitlists", ["user_id"], name: "index_waitlists_on_user_id", using: :btree

  add_foreign_key "reservations", "books"
  add_foreign_key "reservations", "users"
  add_foreign_key "waitlists", "books"
  add_foreign_key "waitlists", "users"
end
