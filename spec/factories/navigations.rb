FactoryGirl.define do
  factory :navigation do
    sequence(:identifier) { |n| "foo-#{n}" }
    description 'foo'
  end
end
