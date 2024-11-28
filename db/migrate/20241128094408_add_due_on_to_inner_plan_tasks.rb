class AddDueOnToInnerPlanTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_tasks, :due_on, :date
  end
end
