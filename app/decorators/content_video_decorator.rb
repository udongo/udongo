class ContentVideoDecorator < ApplicationDecorator
  delegate_all

  def embed_url
    url.to_s.include?('vimeo') ? vimeo_embed_url : youtube_embed_url
  end

  def aspect_ratio_class
    aspect_ratio.to_s.split('x').join('by')
  end

  private

  def vimeo_embed_url
    video_id = /[0-9*]+/.match(url.to_s).to_s
    "https://player.vimeo.com/video/#{video_id}"
  end

  def youtube_embed_url
    video_id = url.to_s.split('v=').last
    "https://www.youtube.com/embed/#{video_id}?rel=0"
  end
end
