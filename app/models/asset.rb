class Asset < ApplicationRecord
  include Concerns::Taggable

  mount_uploader :filename, AssetUploader

  has_many :images, dependent: :destroy
  has_many :content_pictures, dependent: :destroy

  scope :image, -> { where(content_type: %w(image/gif image/jpeg image/png)) }

  before_save :update_filesize, :update_content_type

  validates :filename, presence: true

  def image?
    content_type.to_s.include?('image')
  end

  def image
    Udongo::Assets::Resizer.new(self) if image?
  end

  def actual_filename
    read_attribute(:filename)
  end

  def deletable?
    count_linked_objects.zero?
  end

  def all_linked_objects
    images + content_pictures
  end

  def count_linked_objects
    images.count + content_pictures.count
  end

  private

  def update_filesize
    self.filesize = filename.size
  end

  def update_content_type
    self.content_type = filename.content_type
  end
end
