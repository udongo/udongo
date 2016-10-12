class Address < ApplicationRecord
  include Concerns::Emailable

  belongs_to :addressable, polymorphic: true
  # TODO touch parent when changed
end
