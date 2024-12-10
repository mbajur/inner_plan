# frozen_string_literal: true

FactoryBot.define do
  factory :list, class: 'InnerPlan::List' do
    sequence(:title) { |n| "List #{n}" }
    description { "List description" }

    user
  end
end
