class CreateInnerPlanTables < ActiveRecord::Migration[7.1]
  def change
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

    add_foreign_key "inner_plan_lists", "inner_plan_lists", column: "parent_id"
    add_foreign_key "inner_plan_tasks", "inner_plan_lists", column: "list_id"
  end
end
