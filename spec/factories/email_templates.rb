FactoryGirl.define do
  factory :email_template do
    sequence(:identifier) { |n| "foo-#{n}" }
    description 'foo'
    from_name 'foo'
    from_email 'foo@bar.baz'
  end
end
