class Redirect < ApplicationRecord
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  def enabled?
    !disabled?
  end

  def used!
    count = self.times_used.nil? ? 1 : times_used + 1
    update_attribute :times_used, count
  end

  def works?(base_url: Udongo.config.base.host)
    response = Udongo::Redirects::Test.new(self).perform!(base_url: base_url)
    (base_url + destination_uri) == response.last_effective_url
  end
end
