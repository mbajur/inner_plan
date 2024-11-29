class AddUserIdToInnerPlanTasksInnerPlanGroupsAndInnerPlanLists < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_tasks, :user_id, :integer
    add_column :inner_plan_groups, :user_id, :integer
    add_column :inner_plan_lists, :user_id, :integer

    add_index :inner_plan_tasks, :user_id
    add_index :inner_plan_groups, :user_id
    add_index :inner_plan_lists, :user_id
  end
end
