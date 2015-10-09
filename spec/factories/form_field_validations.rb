FactoryGirl.define do
  factory :form_field_validation do
    form_field
    validation_class "MyString"
  end
end
