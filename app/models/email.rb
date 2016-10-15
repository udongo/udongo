class Email < ApplicationRecord
  validates :from_name, :to_name, :subject, :plain_content, :html_content,
            presence: true
  validates :from_email, :to_email, email: true

  scope :sent, -> { where('sent_at IS NOT NULL') }
  scope :not_sent, -> { where('sent_at IS NULL') }

  def mark_as_sent!
    update_attribute :sent_at, DateTime.now
  end
end
