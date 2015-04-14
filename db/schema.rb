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

ActiveRecord::Schema.define(version: 20150414003249) do

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

  create_table "source_files", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "sha",                            null: false
    t.string   "source_type",                    null: false
    t.string   "language"
    t.string   "linters",        default: [],                 array: true
    t.integer  "modified_lines", default: [],                 array: true
    t.boolean  "generated",      default: false
    t.boolean  "vendored",       default: false
    t.boolean  "documentation",  default: false
    t.boolean  "binary",         default: false
    t.boolean  "image",          default: false
    t.string   "extension",                      null: false
    t.integer  "size",                           null: false
    t.integer  "build_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_results", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "source_file_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "task_results", ["source_file_id"], name: "index_task_results_on_source_file_id", using: :btree
  add_index "task_results", ["task_id"], name: "index_task_results_on_task_id", using: :btree

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

  create_table "violations", force: :cascade do |t|
    t.integer  "line"
    t.integer  "column"
    t.integer  "length"
    t.string   "rule"
    t.string   "severity"
    t.text     "message"
    t.integer  "source_file_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "violations", ["source_file_id"], name: "index_violations_on_source_file_id", using: :btree

  add_foreign_key "task_results", "source_files"
  add_foreign_key "task_results", "tasks"
  add_foreign_key "violations", "source_files"
end
