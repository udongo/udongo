FactoryGirl.define do
  factory :image_collection do
    description 'foo'
    sequence(:identifier) { |n| "foo-#{n}" }
  end
end
