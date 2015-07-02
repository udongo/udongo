class ContentImage < ActiveRecord::Base
  include Concerns::ContentType

  mount_uploader :file, ContentImageUploader
end
