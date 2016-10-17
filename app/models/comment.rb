class Comment < ApplicationRecord
  include Concerns::Parentable
  include Concerns::Locale
  include Concerns::Spammable

  STATUSES = %w(pending_moderation published)

  after_initialize :default_values

  belongs_to :commentable, polymorphic: true

  validates :author, :message, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :email, presence: true, email: true
  validates :website, url: true, allow_blank: true

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

  def default_values
    if self.new_record?
      self.status = 'pending_moderation' if status.nil?
    end
  end
end
