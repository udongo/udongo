class User < ActiveRecord::Base
  include Concerns::Person
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email,
            presence: true,
            email: true,
            uniqueness: { case_sensitive: false }
end
