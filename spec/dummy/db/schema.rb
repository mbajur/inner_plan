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

ActiveRecord::Schema[7.1].define(version: 2024_12_07_085212) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "inner_plan_assignees", force: :cascade do |t|
    t.integer "task_id", null: false
    t.integer "user_id"
    t.integer "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_inner_plan_assignees_on_task_id"
    t.index ["user_id"], name: "index_inner_plan_assignees_on_user_id"
  end

  create_table "inner_plan_attachments", force: :cascade do |t|
    t.integer "user_id"
    t.text "meta", default: "{}"
    t.string "type", null: false
    t.integer "position", null: false
    t.integer "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id", "type", "position"], name: "index_inner_plan_attachments_on_task_id_and_type_and_position", unique: true
    t.index ["task_id"], name: "index_inner_plan_attachments_on_task_id"
    t.index ["user_id"], name: "index_inner_plan_attachments_on_user_id"
  end

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

  create_table "inner_plan_user_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inner_plan_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "inner_plan_assignees", "inner_plan_tasks", column: "task_id"
  add_foreign_key "inner_plan_attachments", "inner_plan_tasks", column: "task_id"
  add_foreign_key "inner_plan_lists", "inner_plan_lists", column: "parent_id"
  add_foreign_key "inner_plan_tasks", "inner_plan_lists", column: "list_id"
end
