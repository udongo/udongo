FactoryGirl.define do
  factory :redirect do
    source_uri '/nl/foo'
    destination_uri '/nl/bar'
    status_code 303
  end
end
