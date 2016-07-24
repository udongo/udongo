class Admin < ApplicationRecord
  include Concerns::Person
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email,
            uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
