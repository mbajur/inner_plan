class CreateInnerPlanAssignees < ActiveRecord::Migration[8.0]
  def change
    create_table :inner_plan_assignees do |t|
      t.references :task, null: false, foreign_key: { to_table: :inner_plan_tasks }
      t.integer :user_id, :integer

      t.timestamps
    end

    add_index :inner_plan_assignees, :user_id
  end
end
