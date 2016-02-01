FactoryGirl.define do
  factory :email do
    from_name 'Foo Bar'
    from_email 'foo@bar.baz'
    to_name 'Bar Foo'
    to_email 'bar@foo.baz'
    subject 'foo'
    plain_content 'foo'
    html_content 'foo'
  end
end
