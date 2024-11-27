class AddGroupToInnerPlanTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :inner_plan_tasks, :group, null: false, foreign_key: { to_table: :inner_plan_groups }
  end
end
