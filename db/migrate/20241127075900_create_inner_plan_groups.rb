class CreateInnerPlanGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :inner_plan_groups do |t|
      t.string :title
      t.boolean :default, default: false
      t.references :list, null: false, foreign_key: { to_table: :inner_plan_lists }
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
