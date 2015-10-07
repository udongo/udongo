FactoryGirl.define do
  factory :navigation do
    sequence(:name) { |n| "foo-#{n}" }
    description 'foo'
  end
end
