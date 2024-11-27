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

ActiveRecord::Schema[8.0].define(version: 2024_11_27_100652) do
  create_table "inner_plan_groups", force: :cascade do |t|
    t.string "title"
    t.boolean "default", default: false
    t.integer "list_id", null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tasks_count", default: 0
    t.integer "completed_tasks_count", default: 0
    t.index ["list_id", "position"], name: "index_inner_plan_groups_on_list_id_and_position", unique: true
    t.index ["list_id"], name: "index_inner_plan_groups_on_list_id"
  end

  create_table "inner_plan_lists", force: :cascade do |t|
    t.string "title"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "completed_tasks_count", default: 0
    t.integer "tasks_count", default: 0
    t.index ["position"], name: "index_inner_plan_lists_on_position", unique: true
  end

  create_table "inner_plan_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id", null: false
    t.integer "position", default: 0
    t.index ["group_id", "position"], name: "index_inner_plan_tasks_on_group_id_and_position", unique: true
    t.index ["group_id"], name: "index_inner_plan_tasks_on_group_id"
  end

  add_foreign_key "inner_plan_groups", "inner_plan_lists", column: "list_id"
  add_foreign_key "inner_plan_tasks", "inner_plan_groups", column: "group_id"
end
