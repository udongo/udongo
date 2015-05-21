FactoryGirl.define do
  factory :content_column do
    association :row, factory: :content_row
    width { rand(1..12) }
  end
end
