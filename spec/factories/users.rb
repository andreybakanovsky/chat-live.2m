# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:email) { |n| "user#{n}@mail.com" }
    online_status { 0 }
    password { '123456' }
  end
end
