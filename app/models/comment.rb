class Comment < ActiveRecord::Base
  # include Concerns::Parentable
  # include Concerns::Spammable

  # spammable author_email: :email, content: :message

  STATUSES = %w(pending_moderation published)

  after_initialize :default_values

  belongs_to :commentable, polymorphic: true

  validates :commentable_id, :commentable_type, :author, :message, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :email, presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :website, url: true, allow_blank: true
  validate :parent_exists?

  scope :by_locale, ->(l) { where(locale: l) }

  def published?
    status.to_s == 'published'
  end

  def publish!
    update_attribute :status, :published
  end

  def unpublish!
    update_attribute :status, :pending_moderation
  end

  private

  def parent_exists?
    if parent_id.present? && !self.class.exists?(parent_id)
      errors.add(:parent_id, :blank)
    end
  end

  def default_values
    if self.new_record?
      self.status = 'pending_moderation' if status.nil?
    end
  end
end

