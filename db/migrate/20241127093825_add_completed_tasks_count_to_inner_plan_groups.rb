class AddCompletedTasksCountToInnerPlanGroups < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_groups, :completed_tasks_count, :integer, default: 0
  end
end
