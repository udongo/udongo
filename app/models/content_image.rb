class ContentImage < ActiveRecord::Base
  mount_uploader :file, ContentImageUploader

  # TODO move to ContentType concern
  def column
    ::ContentColumn.where(content_type: self.class.name, content_id: id).take
  end
end
