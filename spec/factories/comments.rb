FactoryGirl.define do
  factory :comment do
    commentable_id 1
    commentable_type 'Example'
    author 'Foo Bar'
    sequence(:email) { |n| "foo-#{n}@bar.baz" }
    message 'Foo bar baz'
  end
end
