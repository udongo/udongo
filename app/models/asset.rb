class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  has_many :images, dependent: :destroy

  before_save :update_filesize, :update_content_type

  validates :filename, presence: true

  def image?
    content_type.to_s.include?('image')
  end

  def image
    filename if image?
  end

  def actual_filename
    read_attribute(:filename)
  end

  def deletable?
    images.empty?
  end

  private

  def update_filesize
    self.filesize = filename.size
  end

  def update_content_type
    self.content_type = filename.content_type
  end
end
