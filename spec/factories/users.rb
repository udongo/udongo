FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    sequence(:email) { |n| "john.doe.#{n}@example.com" }
    password 'sekret'
    password_confirmation 'sekret'
  end
end
