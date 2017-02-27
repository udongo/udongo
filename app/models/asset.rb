class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  validates :filename, presence: true
end
