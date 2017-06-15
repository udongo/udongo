class ContentSlideshow < ApplicationRecord
  include Concerns::ContentType

  belongs_to :image_collection

  def content_type
    :slideshow
  end
end
