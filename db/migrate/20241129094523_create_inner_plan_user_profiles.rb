class CreateInnerPlanUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :inner_plan_user_profiles do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :inner_plan_user_profiles, :user_id
  end
end
