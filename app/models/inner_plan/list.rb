module InnerPlan
  class List < ApplicationRecord
    has_many :groups
    has_many :tasks, class_name: 'InnerPlan::Task', through: :groups

    positioned

    scope :ordered_by_position, ->{ order(position: :asc) }
  end
end
