class ContentPicture < ApplicationRecord
  include Concerns::ContentType

  TARGETS = %w(_self _blank)

  belongs_to :asset

  def content_type
    :picture
  end
end
