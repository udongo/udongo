FactoryGirl.define do
  factory :asset do
    filename { fixture_file_upload 'spec/fixtures/files/example.jpg', 'application/jpeg' }
    content_type 'image/jpg'
    filesize 46080
  end
end
