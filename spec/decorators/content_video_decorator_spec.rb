require 'rails_helper'

describe ContentVideoDecorator do
  it '#respond_to?' do
    expect(build(:content_video).decorate).to respond_to(:embed_url)
  end
end
