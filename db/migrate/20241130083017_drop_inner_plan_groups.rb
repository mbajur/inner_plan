class DropInnerPlanGroups < ActiveRecord::Migration[8.0]
  def change
    remove_index :inner_plan_tasks, ["group_id", "position"], name: "index_inner_plan_tasks_on_group_id_and_position", unique: true
    remove_reference :inner_plan_tasks, :sub, null: false, foreign_key: { to_table: :inner_plan_groups }
    drop_table :inner_plan_groups
    add_index :inner_plan_tasks, [:list_id, :position], name: "index_inner_plan_tasks_on_list_id_and_position", unique: true
  end
end
