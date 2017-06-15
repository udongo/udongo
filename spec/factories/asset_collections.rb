FactoryGirl.define do
  factory :asset_collection do
    description 'foo'
    sequence(:identifier) { |n| "foo-#{n}" }
  end
end
