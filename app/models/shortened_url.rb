class ShortenedUrl < ActiveRecord::Base
  validates :code, :url, presence: true
end
