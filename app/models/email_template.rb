class EmailTemplate < ApplicationRecord
  include Concerns::Translatable
  translatable_fields :subject, :plain_content, :html_content

  include Concerns::Sortable

  validates :description, :from_name, :from_email, presence: true
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
  validates :from_email, email: true
  validates :cc, :bcc, email: true, allow_blank: true
end
