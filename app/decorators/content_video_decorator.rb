class ContentVideoDecorator < ApplicationDecorator
  delegate_all

  def embed_url
    url
  end

  def aspect_ratio_class
    aspect_ratio.to_s.split('x').join('by')
  end
end
