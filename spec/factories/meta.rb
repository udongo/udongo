FactoryGirl.define do
  factory :meta do
    locale 'nl'
    sequence(:slug) { |n| "foo-#{n}" }
  end
end

