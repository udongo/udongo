FactoryGirl.define do
  factory :content_column do
    association :row, factory: :content_row
    width_xs { rand(1..12) }
    width_sm { rand(1..12) }
    width_md { rand(1..12) }
    width_lg { rand(1..12) }
    width_xl { rand(1..12) }
  end
end
