class AddOngoingTasksCountToInnerPlanGroupsAndInnerPlanLists < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_groups, :ongoing_tasks_count, :integer, default: 0
    add_column :inner_plan_lists, :ongoing_tasks_count, :integer, default: 0
  end
end
