module InnerPlan
  class List < ApplicationRecord
    has_many :tasks, class_name: 'InnerPlan::Task'
    has_many :tasks_including_groups, ->{ where(list_id: id) }
    has_many :lists, foreign_key: :parent_id
    belongs_to :list, foreign_key: :parent_id, optional: true
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name

    positioned

    scope :ordered_by_position, ->{ order(position: :asc) }
    scope :root, ->{ where(parent_id: nil) }
    scope :sub, ->{ where.not(parent_id: nil) }

    has_rich_text :description

    validates :title, presence: true

    def root?
      parent_id.present?
    end

    def sub?
      parent_id.present?
    end
  end
end
