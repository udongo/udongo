class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  validates :filename, presence: true

  def image?
    content_type.include?('image')
  end
end
