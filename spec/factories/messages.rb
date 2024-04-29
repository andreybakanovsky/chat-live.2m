# frozen_string_literal: false

FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "This is the message N#{n}" }
    sender factory: :user
  end
  trait :with_token do
    token { "0000-0001" }
  end
end
