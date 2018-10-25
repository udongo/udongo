class Redirect < ApplicationRecord
  scope :working, -> { where(working: true) }
  scope :broken, -> { where('working IS NULL or working = 0') }
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  before_validation do
    # Adding a leading slash at this point makes sure the uniqueness validation
    # keeps working.
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

  def used!
    count = self.times_used.nil? ? 1 : times_used + 1
    update_attribute :times_used, count
  end

  # This builds a list of all redirects following the current one in its
  # progression path. Includes the current redirect as the first item.
  def progression(stack = [])
    stack << self
    return next_in_chain.progression(stack) if next_in_chain.present?
    stack
  end

  # Tests the redirect including any redirects following this one.
  def works?(base_url: Udongo.config.base.host)
    response = Udongo::Redirects::Test.new(self).perform!(base_url: base_url)
    return next_in_chain.works?(base_url: base_url) if next_in_chain.present?
    response.redirect_works?(base_url + destination_uri)
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
