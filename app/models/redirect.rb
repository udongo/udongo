class Redirect < ApplicationRecord
  scope :working, -> { where(working: true) }
  scope :broken, -> { where('working IS NULL or working = 0') }
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  # Sanitizing at this point makes sure the uniqueness validation keeps working.
  before_validation do
    self.source_uri = convert_to_uri_path(sanitize_uri(source_uri))
    self.destination_uri = sanitize_uri(destination_uri)
  end

  def broken?
    !working?
  end

  def broken!
    update_attribute(:working, false)
  end

  def cache_depth!
    update_attribute(:depth, calculate_depth)
  end

  def calculate_depth(total = 0)
    total += 1
    return next_in_chain.calculate_depth(total) if next_in_chain.present?
    total
  end

  def depth_cacher
    @depth_cacher ||= Udongo::Redirects::DepthCacher.new(self)
  end

  def enabled?
    !disabled?
  end

  def next_in_chain
    self.class.enabled.find_by(source_uri: destination_uri)
  end

  def previous_in_chain
    self.class.enabled.find_by(destination_uri: source_uri)
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
  def trace_down(stack = [])
    stack << self
    return next_in_chain.trace_down(stack) if next_in_chain.present?
    stack
  end

  # This builds a list of all redirects prior to the current one in its
  # progression path. Includes the current redirect as the first item.
  # See #previous_in_chain for the trace conditions.
  def trace_up(stack = [])
    stack << self
    return previous_in_chain.trace_up(stack) if previous_in_chain.present?
    stack.reverse # Reversing because the top most one will be at the end.
  end

  def used!
    count = self.times_used.nil? ? 1 : times_used + 1
    update_attribute :times_used, count
  end

  def working!
    update_attribute(:working, true)
  end

  private

  def convert_to_uri_path(value)
    URI::parse(value.to_s).path
  end

  def sanitize_uri(value)
    return if value.blank?
    Udongo::Redirects::UriSanitizer.new(value).sanitize!
  end
end
