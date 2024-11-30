module InnerPlan
  class List < ApplicationRecord
    has_many :groups
    has_many :tasks, class_name: 'InnerPlan::Task', through: :groups
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name

    positioned

    scope :ordered_by_position, ->{ order(position: :asc) }

    has_rich_text :description

    validates :title, presence: true
  end
end
