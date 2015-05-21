FactoryGirl.define do
  factory :tag do
    locale 'nl'
    sequence(:name) { |n| "tag #{n}" }
    sequence(:slug) { |n| "tag-#{n}" }
  end
end
