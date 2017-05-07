class ContentVideo < ApplicationRecord
  include Concerns::ContentType

  ASPECT_RATIOS = %w(16x9 21x9 4x3 1x1)

  belongs_to :asset

  def content_type
    :video
  end
end
