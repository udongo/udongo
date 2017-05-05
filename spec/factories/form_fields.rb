FactoryGirl.define do
  factory :form_field do
    form
    sequence(:identifier) { |n| "name-#{n}" }
    field_type 'text'
  end
end
