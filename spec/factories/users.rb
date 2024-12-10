# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user_#{i}@example.com" }
    password { 'ChangeMe666' }
    password_confirmation { 'ChangeMe666' }
  end
end
