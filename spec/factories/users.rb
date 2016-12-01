FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john.doe.#{n}@example.com" }
    first_name 'John'
    last_name 'Doe'
    password 'internet'
  end
end
