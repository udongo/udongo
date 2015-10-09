FactoryGirl.define do
  factory :form_field_validation do
    association :field, factory: :form_field
    validation_class "MyString"
  end
end
