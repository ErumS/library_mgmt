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

ActiveRecord::Schema.define(version: 20180119053040) do

  create_table "book_issues", force: :cascade do |t|
    t.integer  "book_id",          limit: 4
    t.integer  "issue_history_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "book_issues", ["book_id"], name: "index_book_issues_on_book_id", using: :btree
  add_index "book_issues", ["issue_history_id"], name: "index_book_issues_on_issue_history_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.string   "author",      limit: 255
    t.decimal  "price",                   precision: 6, scale: 2
    t.string   "publication", limit: 255
    t.string   "version",     limit: 255
    t.integer  "library_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.integer  "member_id",   limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree
  add_index "books", ["library_id"], name: "index_books_on_library_id", using: :btree
  add_index "books", ["member_id"], name: "index_books_on_member_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "department", limit: 255
    t.integer  "library_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["library_id"], name: "index_categories_on_library_id", using: :btree

  create_table "issue_histories", force: :cascade do |t|
    t.date     "issue_date"
    t.date     "return_date"
    t.integer  "copies",      limit: 4
    t.integer  "member_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "issue_histories", ["member_id"], name: "index_issue_histories_on_member_id", using: :btree

  create_table "libraries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "phone_no",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "address",       limit: 65535
    t.string   "phone_no",      limit: 255
    t.string   "gender",        limit: 255
    t.string   "code",          limit: 255
    t.date     "validity_date"
    t.boolean  "is_author",                   default: false
    t.integer  "library_id",    limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "members", ["library_id"], name: "index_members_on_library_id", using: :btree

  add_foreign_key "book_issues", "books"
  add_foreign_key "book_issues", "issue_histories"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "libraries"
  add_foreign_key "books", "members"
  add_foreign_key "categories", "libraries"
  add_foreign_key "issue_histories", "members"
  add_foreign_key "members", "libraries"
end
