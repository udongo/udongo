class ContentVideoDecorator < ApplicationDecorator
  delegate_all

  def embed_url
    url
  end

  def aspect_ratio_class
    '16by9'
  end
end
