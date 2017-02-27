class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  before_save :update_filesize, :update_content_type

  validates :filename, presence: true

  def image?
    content_type.include?('image')
  end

  def extension
    read_attribute(:filename).split('.').last
  end

  private

  def update_filesize
    self.filesize = filename.size
  end

  def update_content_type
    self.content_type = filename.content_type
  end
end
