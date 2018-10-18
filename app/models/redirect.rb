class Redirect < ApplicationRecord
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  def enabled?
    !disabled?
  end

  def next_in_chain
    self.class.find_by(source_uri: destination_uri)
  end

  def used!
    count = self.times_used.nil? ? 1 : times_used + 1
    update_attribute :times_used, count
  end

  def works?(base_url: Udongo.config.base.host)
    response = Udongo::Redirects::Test.new(self).perform!(base_url: base_url)
    return next_in_chain.works?(base_url: base_url) if next_in_chain.present?
    (base_url + destination_uri) == response.last_effective_url
  end
end
