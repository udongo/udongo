class Redirect < ActiveRecord::Base
  validates :source, :destination, :status_code, presence: true
end
