class CreateInnerPlanLists < ActiveRecord::Migration[8.0]
  def change
    create_table :inner_plan_lists do |t|
      t.string :title
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
