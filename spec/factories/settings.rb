FactoryGirl.define do
  factory :setting do
    sequence(:name) { |n| "name-#{n}" }
    description 'foo'
  end
end

