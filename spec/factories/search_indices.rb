FactoryGirl.define do
  factory :search_index do
    searchable_id 1
    searchable_type 'Page'
    locale 'nl'
    key 'foo'
    value 'bar'
  end
end
