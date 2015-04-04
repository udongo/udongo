FactoryGirl.define do
  factory :udongo_admin, class: 'Udongo::Admin' do
    first_name 'foo'
    last_name 'bar'
    sequence(:email) { |n| "foo-#{n}@bar.baz" }
    password 'sekret'
    password_confirmation 'sekret'
  end
end
