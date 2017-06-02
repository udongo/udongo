class ContentForm < ApplicationRecord
  include Concerns::ContentType

  belongs_to :form

  def content_type
    :form
  end
end
