class AddListToInnerPlanTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :inner_plan_tasks, :list, null: true, foreign_key: { to_table: :inner_plan_lists }
  end
end
