require 'rails_helper'

describe ContentVideoDecorator do
  describe '#embed_url' do
    describe 'youtube' do
      it 'https://www.youtube.com/watch?v=kaTccjimkLw' do
        video = create(:content_video, url: 'https://www.youtube.com/watch?v=kaTccjimkLw').decorate
        expect(video.embed_url).to eq 'https://www.youtube.com/embed/kaTccjimkLw?rel=0'
      end
    end

    describe 'vimeo' do
      it 'https://vimeo.com/179742663' do
        video = create(:content_video, url: 'https://vimeo.com/179742663').decorate
        expect(video.embed_url).to eq 'https://player.vimeo.com/video/179742663'
      end
    end
  end

  describe '#aspect_ratio_class' do
    it '16x9' do
      video = create(:content_video, aspect_ratio: '16x9').decorate
      expect(video.aspect_ratio_class).to eq '16by9'
    end

    it '21x9' do
      video = create(:content_video, aspect_ratio: '21x9').decorate
      expect(video.aspect_ratio_class).to eq '21by9'
    end

    it '4x3' do
      video = create(:content_video, aspect_ratio: '4x3').decorate
      expect(video.aspect_ratio_class).to eq '4by3'
    end

    it '1x1' do
      video = create(:content_video, aspect_ratio: '1x1').decorate
      expect(video.aspect_ratio_class).to eq '1by1'
    end
  end

  it '#respond_to?' do
    expect(build(:content_video).decorate).to respond_to(
      :embed_url, :aspect_ratio_class
    )
  end
end
