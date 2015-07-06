FactoryGirl.define do
  factory :snippet do
    sequence(:identifier) { |n| "identifier-#{n}" }
  end
end
