# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_05_203943) do
  create_table "inner_plan_lists", force: :cascade do |t|
    t.string "title"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "completed_tasks_count", default: 0
    t.integer "tasks_count", default: 0
    t.integer "ongoing_tasks_count", default: 0
    t.integer "user_id"
    t.integer "parent_id"
    t.text "description"
    t.index ["parent_id"], name: "index_inner_plan_lists_on_parent_id"
    t.index ["position"], name: "index_inner_plan_lists_on_position", unique: true
    t.index ["user_id"], name: "index_inner_plan_lists_on_user_id"
  end

  create_table "inner_plan_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.date "due_on"
    t.integer "user_id"
    t.integer "list_id"
    t.index ["list_id", "position"], name: "index_inner_plan_tasks_on_list_id_and_position", unique: true
    t.index ["list_id"], name: "index_inner_plan_tasks_on_list_id"
    t.index ["user_id"], name: "index_inner_plan_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "inner_plan_lists", "inner_plan_lists", column: "parent_id"
  add_foreign_key "inner_plan_tasks", "inner_plan_lists", column: "list_id"
end
