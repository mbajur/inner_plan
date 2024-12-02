class AddParentToInnerPlanLists < ActiveRecord::Migration[8.0]
  def change
    add_reference :inner_plan_lists, :parent, null: true, foreign_key: { to_table: :inner_plan_lists }
  end
end
