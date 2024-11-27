module InnerPlan
  class Group < ApplicationRecord
    belongs_to :list
    has_many :tasks

    positioned on: :list

    scope :ordered_by_position, ->{ order(position: :asc) }
  end
end
