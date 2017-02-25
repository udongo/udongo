class Asset < ApplicationRecord
  include Concerns::Taggable

  validates :filename, presence: true
end
