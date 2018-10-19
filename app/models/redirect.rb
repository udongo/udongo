class Redirect < ApplicationRecord
  scope :disabled, -> { where(disabled: true) }
  scope :enabled, -> { where('disabled IS NULL or disabled = 0') }

  validates :source_uri, :destination_uri, :status_code, presence: true
  validates :source_uri, uniqueness: { case_sensitive: false }

  before_validation do
    # Adding a leading slash at this point makes sure the uniqueness validation
    # keeps working.
    self.source_uri = sanitize_slashes(source_uri)
    self.destination_uri = sanitize_slashes(destination_uri)
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

  def works?(base_url: Udongo.config.base.host)
    response = Udongo::Redirects::Test.new(self).perform!(base_url: base_url)
    return next_in_chain.works?(base_url: base_url) if next_in_chain.present?
    response.redirect_works?(base_url + destination_uri)
  end

  private

  def sanitize_slashes(value)
    return if value.blank?
    value.gsub(/^(?!\/)/, '/')
         .chomp('/')
         .gsub('/?', '?').gsub('/#', '#')
  end
end
