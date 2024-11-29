module InnerPlan
  class Assignee < ApplicationRecord
    belongs_to :task
    belongs_to :user
  end
end
