class ContentImage < ActiveRecord::Base
  mount_uploader :file, ContentImageUploader
end
