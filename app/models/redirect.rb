class Redirect < ActiveRecord::Base
  validates :source_uri, :destination_uri, :status_code, presence: true
end
