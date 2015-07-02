require 'rails_helper'

describe ContentImageDecorator do
  it '#text?' do
    expect(build(:content_image).decorate).not_to be_text
  end

  it '#image?' do
    expect(build(:content_image).decorate).to be_image
  end

  it '#respond_to?' do
    expect(build(:content_image).decorate).to respond_to(:text?, :image?)
  end
end
