module InnerPlan
  class Group < ApplicationRecord
    belongs_to :list
    has_many :tasks
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name

    positioned on: :list

    scope :ordered_by_position, ->{ order(position: :asc) }
    scope :default, ->{ where(default: true) }

    has_rich_text :description
  end
end
