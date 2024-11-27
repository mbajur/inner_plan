class CreateInnerPlanTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :inner_plan_tasks do |t|
      t.string :title
      t.text :description
      t.datetime :completed_at

      t.timestamps
    end
  end
end
