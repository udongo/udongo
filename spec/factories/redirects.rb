FactoryGirl.define do
  factory :redirect do
    source '/nl/foo'
    destination '/nl/bar'
    status_code 303
  end
end
