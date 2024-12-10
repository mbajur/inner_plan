# frozen_string_literal: true

FactoryBot.define do
  factory :task, class: 'InnerPlan::Task' do
    sequence(:title) { |n| "Task #{n}" }
    description { "Group description" }

    list
    user
  end
end
