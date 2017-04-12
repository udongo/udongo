class ContentPicture < ApplicationRecord
  include Concerns::ContentType

  belongs_to :asset

  def content_type
    :picture
  end
end
