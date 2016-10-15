class Admin < ApplicationRecord
  include Concerns::Person
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email,
            uniqueness: { case_sensitive: false },
            email: true
end
