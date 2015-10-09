FactoryGirl.define do
  factory :form_submission_data do
    association :submission, factory: :form_submission
    name "MyString"
    value "MyText"
  end
end
