FactoryGirl.define do
  factory :asset do
    filename { fixture_file_upload 'spec/fixtures/files/example.jpg', 'application/jpeg' }
  end
end
