class Email < ActiveRecord::Base
  validates :from_name, :to_name, :subject, :plain_content, :html_content, :sent_at,
            presence: true
  validates :from_email, :to_email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
