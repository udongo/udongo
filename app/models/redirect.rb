class Redirect < ActiveRecord::Base
  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  scope :disabled, -> { where('disabled = 1') }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  def enabled?
    !disabled?
  end
end
