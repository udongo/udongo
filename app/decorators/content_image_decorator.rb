class ContentImageDecorator < ApplicationDecorator
  delegate_all

  def content_type_is?(value)
    value.to_sym == :image
  end
end
