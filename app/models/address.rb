class Address < ApplicationRecord
  include Concerns::Emailable

  belongs_to :addressable, polymorphic: true
end
