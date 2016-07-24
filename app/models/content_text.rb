class ContentText < ApplicationRecord
  include Concerns::ContentType

  def content_type
    :text
  end
end
