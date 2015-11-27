class ContentText < ActiveRecord::Base
  include Concerns::ContentType

  def content_type
    :text
  end
end
