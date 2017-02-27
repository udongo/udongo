class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  before_save :update_filesize, :update_content_type

  validates :filename, presence: true

  def image?
    content_type.include?('image')
  end

  def image_url(width = nil, height = nil, action: :resize_to_limit, options: {})
    return unless image?

    Udongo::Assets::Resize.new(self).url(
      width,
      height,
      action: action,
      options: options
    )
  end

  # TODO remove?
  def extension
    read_attribute(:filename).split('.').last
  end

  # TODO keep?
  def name_with_extension
    read_attribute(:filename)
  end

  private

  def update_filesize
    self.filesize = filename.size
  end

  def update_content_type
    self.content_type = filename.content_type
  end
end
