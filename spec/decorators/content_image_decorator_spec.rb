require 'rails_helper'

describe ContentImageDecorator do
  describe '#content_type_is?' do
    it :true do
      expect(build(:content_image).decorate).to be_content_type_is(:image)
      expect(build(:content_image).decorate).to be_content_type_is('image')
    end

    it :false do
      expect(build(:content_image).decorate).not_to be_content_type_is(:text)
    end
  end

  it '#respond_to?' do
    expect(build(:content_image).decorate).to respond_to(:content_type_is?)
  end
end
