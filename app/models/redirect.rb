class Redirect < ApplicationRecord
  scope :working, -> { where(working: true) }
  scope :broken, -> { where('working IS NULL or working = 0') }
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  # Sanitizing at this point makes sure the uniqueness validation keeps working.
  before_validation do
    self.source_uri = sanitize_uri(source_uri)
    self.destination_uri = sanitize_uri(destination_uri)
  end

  def broken?
    !working?
  end

  def broken!
    update_attribute(:working, false)
  end

  def enabled?
    !disabled?
  end

  def next_in_chain
    self.class.find_by(source_uri: destination_uri)
  end

  # Tests the redirect including any redirects following this one.
  def resolves?(base_url: Udongo.config.base.host, follow_location: true)
    response = Udongo::Redirects::Test.new(self).perform!(
      base_url: base_url,
      follow_location: follow_location
    )

    response.success? && response.endpoint_matches?(base_url + destination_uri)
  end

  # This builds a list of all redirects following the current one in its
  # progression path. Includes the current redirect as the first item.
  # See #next_in_chain for the trace conditions.
  def trace(stack = [])
    stack << self
    return next_in_chain.trace(stack) if next_in_chain.present?
    stack
  end

  def used!
    count = self.times_used.nil? ? 1 : times_used + 1
    update_attribute :times_used, count
  end

  def working!
    update_attribute(:working, true)
  end

  private

  def sanitize_uri(value)
    return if value.blank?
    value.strip # Leading/trailing Whitespace
         .gsub(/^(?!\/)/, '/') # Leading slashes
         .chomp('/').gsub('/?', '?').gsub('/#', '#') # Forward slashes
  end
end
