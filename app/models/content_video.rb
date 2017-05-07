class ContentVideo < ApplicationRecord
  include Concerns::ContentType

  belongs_to :asset

  def content_type
    :video
  end
end
