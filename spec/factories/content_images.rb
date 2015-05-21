FactoryGirl.define do
  factory :content_image do
    file { fixture_file_upload 'spec/fixtures/files/example.jpg', 'application/jpeg' }

    after(:create) do |file, proxy|
      proxy.file.close
    end
  end
end
