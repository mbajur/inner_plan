# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: 'InnerPlan::List' do
    sequence(:title) { |n| "Group #{n}" }
    description { "Group description" }

    list
    user
  end
end
