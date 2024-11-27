class AddUniqueConstraintToTaskPosition < ActiveRecord::Migration[8.0]
  def change
    add_column :inner_plan_tasks, :position, :integer, default: 0

    add_index :inner_plan_tasks, [:group_id, :position], unique: true
    add_index :inner_plan_groups, [:list_id, :position], unique: true
    add_index :inner_plan_lists, :position, unique: true
  end
end
