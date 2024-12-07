module InnerPlan
  class List < ApplicationRecord
    has_many :tasks, class_name: 'InnerPlan::Task'
    has_many :tasks_including_groups, ->(list){ rewhere(list_id: ([list.id] + list.lists.pluck(:id))) }, class_name: 'InnerPlan::Task'
    has_many :lists, foreign_key: :parent_id
    belongs_to :list, foreign_key: :parent_id, optional: true
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name

    positioned

    scope :ordered_by_position, ->{ order(position: :asc) }
    scope :root, ->{ where(parent_id: nil) }
    scope :sub, ->{ where.not(parent_id: nil) }

    validates :title, presence: true

    def root?
      parent_id.blank?
    end

    def sub?
      parent_id.present?
    end

    def to_param
      [id.to_s, title.to_url(limit: 50, truncate_words: false)].join('-')
    end
  end
end
