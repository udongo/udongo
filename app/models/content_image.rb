class ContentImage < ActiveRecord::Base
  include Concerns::ContentType

  mount_uploader :file, ContentImageUploader

  def content_type
    :image
  end
end
