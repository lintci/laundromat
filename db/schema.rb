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

ActiveRecord::Schema.define(version: 20141206222739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builds", force: :cascade do |t|
    t.string   "event",         null: false
    t.string   "event_id",      null: false
    t.json     "payload",       null: false
    t.integer  "repository_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "builds", ["repository_id"], name: "index_builds_on_repository_id", using: :btree

  create_table "modified_files", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "lines",        null: false, array: true
    t.integer  "lint_task_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "modified_files", ["lint_task_id"], name: "index_modified_files_on_lint_task_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "full_name",  null: false
    t.integer  "owner_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositories", ["owner_id"], name: "index_repositories_on_owner_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "language"
    t.string   "tool"
    t.string   "status",      null: false
    t.string   "type",        null: false
    t.integer  "build_id",    null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["build_id"], name: "index_tasks_on_build_id", using: :btree

end
