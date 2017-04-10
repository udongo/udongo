FactoryGirl.define do
  factory :form_field do
    form
    identifier 'name'
    field_type 'text'
  end
end
