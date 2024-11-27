class AddCompletedTasksCountAndTasksCountToInnerPlanLists < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_lists, :completed_tasks_count, :integer, default: 0
    add_column :inner_plan_lists, :tasks_count, :integer, default: 0
  end
end
