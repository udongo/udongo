FactoryGirl.define do
  factory :snippet do
    sequence(:identifier) { |n| "identifier-#{n}" }
    description 'Foo'
  end
end
