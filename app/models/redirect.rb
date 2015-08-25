class Redirect < ActiveRecord::Base
  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  def enabled?
    !disabled?
  end
end
