FactoryGirl.define do
  factory :search_synonym do
    locale 'nl'
    term 'fubar'
    synonyms 'Foo,Bar'
  end
end
